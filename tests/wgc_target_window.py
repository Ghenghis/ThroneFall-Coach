"""A stand-in 'game window' for the real-WGC test: a plain Win32 window (own thread + message loop) that paints a moving white square on a
solid background about 60 times a second. Needs pywin32. Several can exist at once (the 'cover' window is another instance)."""
import threading
import time

import win32api
import win32con
import win32gui


class TargetWindow:
    _n = 0

    def __init__(self, title="LivecapTest", cls=None, x=60, y=60, w=800, h=600, bg=(20, 40, 200), animated=True, topmost=False):
        TargetWindow._n += 1
        self.title, self.cls = title, cls or "LivecapTestWnd%d" % TargetWindow._n
        self.x, self.y, self.w, self.h, self.bg, self.animated, self.topmost = x, y, w, h, bg, animated, topmost
        self.hwnd = None
        self.frame = 0
        self.ready = threading.Event()
        self.thread = threading.Thread(target=self._run, daemon=True)
        self.thread.start()
        if not self.ready.wait(10):
            raise RuntimeError("window did not open")

    def _wndproc(self, hwnd, msg, wp, lp):
        if msg == win32con.WM_PAINT:
            hdc, ps = win32gui.BeginPaint(hwnd)
            l, t, r, b = win32gui.GetClientRect(hwnd)
            br = win32gui.CreateSolidBrush(win32api.RGB(*self.bg))
            win32gui.FillRect(hdc, (l, t, r, b), br)
            win32gui.DeleteObject(br)
            if self.animated:
                bx = int((self.frame * 9) % max(1, (r - 120)))
                wbr = win32gui.CreateSolidBrush(win32api.RGB(255, 255, 255))
                win32gui.FillRect(hdc, (bx, (b - t) // 2 - 50, bx + 100, (b - t) // 2 + 50), wbr)
                win32gui.DeleteObject(wbr)
            win32gui.EndPaint(hwnd, ps)
            return 0
        if msg == win32con.WM_TIMER:
            self.frame += 1
            win32gui.InvalidateRect(hwnd, None, False)
            return 0
        if msg == win32con.WM_ERASEBKGND:
            return 1
        if msg == win32con.WM_DESTROY:
            win32gui.PostQuitMessage(0)
            return 0
        return win32gui.DefWindowProc(hwnd, msg, wp, lp)

    def _run(self):
        wc = win32gui.WNDCLASS()
        wc.hInstance = win32api.GetModuleHandle(None)
        wc.lpszClassName = self.cls
        wc.lpfnWndProc = self._wndproc
        wc.hCursor = win32gui.LoadCursor(0, win32con.IDC_ARROW)
        win32gui.RegisterClass(wc)
        ex = win32con.WS_EX_TOPMOST if self.topmost else 0
        self.hwnd = win32gui.CreateWindowEx(ex, self.cls, self.title, win32con.WS_OVERLAPPEDWINDOW | win32con.WS_VISIBLE, self.x, self.y, self.w, self.h, 0, 0, wc.hInstance, None)
        if self.animated:
            import ctypes
            import ctypes.wintypes as wt
            ctypes.windll.user32.SetTimer.argtypes = [wt.HWND, ctypes.c_size_t, wt.UINT, ctypes.c_void_p]
            ctypes.windll.user32.SetTimer(self.hwnd, 1, 16, None)
        win32gui.ShowWindow(self.hwnd, win32con.SW_SHOWNOACTIVATE)
        self.ready.set()
        win32gui.PumpMessages()

    def minimize(self):
        win32gui.ShowWindow(self.hwnd, win32con.SW_SHOWMINNOACTIVE)

    def restore(self):
        win32gui.ShowWindow(self.hwnd, win32con.SW_SHOWNOACTIVATE)

    def close(self):
        try:
            win32gui.PostMessage(self.hwnd, win32con.WM_CLOSE, 0, 0)
        except Exception:
            pass
        self.thread.join(3)
