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

*TODO*: If your format has options that can be set via document metadata, describe them.

## Example

Here is the source code for a minimal sample document: [template.qmd](template.qmd).


## License

This modifies the Overleaf APSR - American Political Science Review Submission Template, available at <https://www.overleaf.com/latex/templates/apsr-american-political-science-review-submission-template/fxffppspqczt>. The original template is licensed under the [Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

