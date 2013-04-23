wemacs
======
Text editor built to run on a WebView, with key bindings inspired on Emacs.

The project aims to have an extensible UI (hence the use of HTML) and have a clean code, so Slim, SASS and CoffeeScript are being used. Also Ruby 1.9.3+ is required.

After cloning, you may run it with:
```sh
cd wemacs/server
bundle
mkdir public
rackup -D -p 5000 server.ru
cd ..
python wemacs.py
```


### TODO / Next steps
* <del>Use proper ace syntax highlighters (aka modes) when files are open</del>
* Add sublevels to file browser
* Make file browser optional
* Make scrollbars optional
* Add a command for opening files
* Minify compiled assets
* Add multiple editors in one screen
* Place all compiled files on public/ folder
