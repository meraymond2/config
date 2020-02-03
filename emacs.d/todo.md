# To Do
Install projectile.
Install whichkey
Install treemacs
Either save on blur, or display unsaved buffers in a more obvious way?

## UI
Change font for non-editor buffers?
Top padding would be nice.
Make the bar less hideous.

## Menu
Play with Ivy settings, try to fix sort-order.
Ivy faces.
Swiper faces.

## Editing
Multiple cursors package.

Bind-keys/write functions for:
- duplicate current line
- move line up/down

## Clojure
Check out lsp-ui, bits of it may be useful.
When I have key-shortcuts/hydra set up, write a format function that 
- formats the entire file
- balances everything
- organises the namespaces
- other options if they exist

## Next Languages, Go/Zig
Pull out settings that only apply to dev-buffers (rm-trailing-whitespace, add-newline-on-save, highlight-whitespace) into a dev-mode function, or mode.

## Markdown
Faces.

## Done
Make trailing spaces change the foreground, not background colour. 
Get rid of the line-wrapping chars.
Remove face for too-long-lines.
Fix face for dired padding.
Enable this thing: https://www.gnu.org/software/emacs/manual/html_node/efaq/Replacing-highlighted-text.html so you can overwrite selected text
Don't allow wrapping in the middle of a word.
Change the theme to make the whitespace marks only visible for leading/trailing whitespace, if possible. UPDATE: not possible, at least not easily
Shrink text a point or two.
Get rid of the scrollbar on the right.
Fix company mode whitespace faces. (not perfect but good enough)
Install Hydra. It would be nice to have those on top of the default key-bindings, I'd like to leave those in place as much as possible.
