# APSR Quarto Format

## Creating a New Article

To create a new article using this format:

```bash
quarto use template christopherkenny/apsr
```

This will create a new directory with an example document that uses this format.

## Using with an Existing Document

To add this format to an existing document:

```bash
quarto add christopherkenny/apsr
```

Then, add the format to your document options:

```yaml
format:
  apsr-pdf: default
```    

## Options

- This template is locked in to use `bibtex`.
- Other options can be set using the `classoption` in the header:
  - `twocolumn`: Switch to two column for main text
  - `singlespace`/`onehalfspace`/**`doublespace`**: 
         changes line spacing for main text
  - **`blind`**/`nonblind`: Anonymises authors 
         and affiliations, or not
    - this option can also be set by making `nonblind: true` in the header


## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).

<!-- pdftools::pdf_convert('template.pdf',pages = 1) -->
![[template.qmd](template.qmd)](template_1.png)


## License

This modifies the Overleaf APSR - American Political Science Review Submission Template, available at <https://www.overleaf.com/latex/templates/apsr-american-political-science-review-submission-template/fxffppspqczt>. The original template is licensed under the [Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

