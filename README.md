# Publish `Anaconda` Package

A `Github Action` to publish your package to an `Anaconda` repository.

### Example workflow to publish to `conda` every time you make a new release

```yaml
name: publish_conda

on:
  release:
    types: [published]
    
jobs:
  publish:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
    - name: publish-to-conda
      uses: maxibor/conda-package-publish-action@v1.1
      with:
        subDir: 'conda'
        anacondaToken: ${{ secrets.ANACONDA_TOKEN }}
```

### Example project structure

```
.
├── LICENSE
├── README.md
├── myproject
│   ├── __init__.py
│   └── myproject.py
├── conda
│   ├── build.sh
│   └── meta.yaml
├── .github
│   └── workflows
│       └── publish_conda.yml
├── .gitignore
```

### ANACONDA_TOKEN

1. Get an Anaconda token (with read and write `API` access) at `https://anaconda.org/<YOUR_USERNAME>/settings/access` 
2. Add it to the secrets of the `Github` repository as `ANACONDA_TOKEN`

### Build Channels
By default, this `Github Action` will search for `conda` build dependancies (on top of the standard channels) in `conda-forge`
