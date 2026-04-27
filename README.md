## Quick CV Updates

Edit [_data/cv.yml](_data/cv.yml). This is the main file for CV, research, and teaching updates.

Then run:

```sh
ruby scripts/build_cv.rb
```

This updates both:

- [files/main_CV.tex](files/main_CV.tex)
- [files/main_CV.pdf](files/main_CV.pdf)

The CV page, research page, and teaching page also read from [_data/cv.yml](_data/cv.yml), so the website stays in sync.

If you only want to update the LaTeX file and skip the PDF build, run:

```sh
ruby scripts/build_cv.rb --no-pdf
```

## Ruby Note

I recommend installing Ruby 3 only through Homebrew or a Ruby version manager, not by replacing macOS's system Ruby. That is low risk: other Mac programs can keep using the system Ruby, while this website uses the newer Ruby when you open this project.

## How This Works

The trick is that the repeated CV information now lives once, in [_data/cv.yml](_data/cv.yml). Jekyll reads that file for the website pages, and [scripts/build_cv.rb](scripts/build_cv.rb) reads the same file to rebuild the LaTeX CV and PDF. So one data edit updates the web version and the PDF version.
