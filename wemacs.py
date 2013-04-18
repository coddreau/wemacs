import gtk
import webkit
import jswebkit

window = gtk.Window()
box = gtk.VBox(homogeneous=False, spacing=0)
webview = webkit.WebView()
window.set_default_size(800, 600)
window.add(box)
box.pack_start(webview, expand=True, fill=True, padding=0)
window.show_all()
webview.open('http://localhost:5000')
js = jswebkit.JSContext(webview.get_main_frame().get_global_context())
gtk.main()
