# Merge-PDF.html

- Simple browser-based 'page' (all local) to securely merge .pdf files using [pdf-lib](https://pdf-lib.js.org/).
- Does not require any internet connectivity, files are accessed at runtime and are not modified. Simply check each page and create a new .pdf from them.
- **Note:** Does rely on the pdf-lib.min.js file being present (by default in the same directory), this can be changed via L12: `<script src="pdf-lib.min.js"></script>`
- pdf-lib.min.js *can* be sourced online, but has been stored locally to qualm any worries that a URL would be modified (maliciously or otherwise) at a later date.