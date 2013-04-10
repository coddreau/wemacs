wemacs
======

Text editor built to run on a WebView, with key bindings inspired on Emacs.

#### Running (v1)

Compile the .slim file to .html

`gem install slim`

`slimrb main.slim > main.html`

Start the server (futurely this will be done in python, running together with the GTK application)

`rackup -p 5000 wemacs-server.ru`

Run the application and code!

`python wemacs.py`
