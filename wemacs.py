import gtk
import webkit

window = gtk.Window()
box = gtk.VBox(homogeneous=False, spacing=0)
webview = webkit.WebView()
window.set_default_size(800, 600)
window.add(box)
box.pack_start(webview, expand=True, fill=True, padding=0)
window.show_all()
webview.open('http://localhost:5000')
gtk.main()
