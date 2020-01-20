# To Do

## UI
Fonts.

Get rid of the scrollbar on the right.

Top padding would be nice.

Make the bar less hideous.

√ Add line numbers.

Whitespace chars for leading and trailing. With the built-in mode it's only possible to set those to faces, but I want something I can count. If you set them to chars with the built-in one, it's for _all_ whitespace.

Eventually, maybe a custom theme.

Get rid of the line-wrapping chars.

## Auto-Complete
Helm probably?

## Keybindings
I liked Hydra. It would be nice to have those on top of the default key-bindings, I'd like to leave those in place as much as possible.

## Editing
Enable this thing:
https://www.gnu.org/software/emacs/manual/html_node/efaq/Replacing-highlighted-text.html
so you can overwrite selected text

Bind-keys/write functions for:
- duplicate current line
- move line up/down
- multiple cursors
- delete current line, if there's not already a shortcut for that

## Clojure
I'm fairly happy with the LSP. I think it means I don't need to touch flycheck (flymake seems to come as part of lsp).

~~Needs autocompletion~~ There's auto complete coming from cider and LSP. I've got M-TAB and Shift-TAB, but I'm not quite sure when each works, but between the two of them, it's pretty decent.

Check out lsp-ui, bits of it may be useful.

√ Get something for parens, and make sure it inserts them correctly when the cursor is in front of something already.

When I have key-shortcuts/hydra set up, write a format function that 
- formats the entire file
- balances everything
- organises the namespaces
- other options if they exist
