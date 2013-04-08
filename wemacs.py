import gtk
import webkit

window = gtk.Window()
box = gtk.VBox(homogeneous=False, spacing=0)
browser = webkit.WebView()
window.set_default_size(800, 600)
window.add(box)
box.pack_start(browser, expand=True, fill=True, padding=0)
window.show_all()
browser.open('http://localhost:3000')
gtk.main()
