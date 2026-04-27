## Quick CV Updates

Most updates should happen in [_data/cv.yml](_data/cv.yml). That file is the shared source for the website CV page, research page, teaching page, LaTeX CV, and PDF CV.

After editing [_data/cv.yml](_data/cv.yml), run:

```sh
ruby scripts/build_cv.rb
```

That command updates both:

- [files/main_CV.tex](files/main_CV.tex)
- [files/main_CV.pdf](files/main_CV.pdf)

The website pages read [_data/cv.yml](_data/cv.yml) automatically when Jekyll builds the site.

If you only want to update the LaTeX file and skip the PDF build, run:

```sh
ruby scripts/build_cv.rb --no-pdf
```

## What To Edit

- Contact details: edit `profile` in [_data/cv.yml](_data/cv.yml).
- Jobs: edit `employment`.
- Degrees: edit `education`.
- Published and working papers: edit `research`.
- Courses and teaching awards: edit `teaching`.
- Conferences, referee service, and awards: edit `professional_activities` and `awards`.

For each paper, use this pattern:

```yml
- title: Paper Title
	url: https://example.com
	authors: Coauthor A and Coauthor B
	notes:
		- Journal or status line
		- Award line
```

If a paper has no link, leave out `url`. If it has no coauthors, leave out `authors`. If it has no notes, leave out `notes`.

## What Not To Edit Most Of The Time

- Do not manually edit [files/main_CV.tex](files/main_CV.tex) for content changes. It is generated from [_data/cv.yml](_data/cv.yml).
- Do not manually replace [files/main_CV.pdf](files/main_CV.pdf). Rebuild it with `ruby scripts/build_cv.rb`.
- Do not edit the research, teaching, or CV page files for content changes unless you are changing page layout.

## Page Layout Files

These files control how the shared data appears on the website:

- [_pages/cv.md](_pages/cv.md)
- [_pages/research.md](_pages/research.md)
- [_pages/teaching.md](_pages/teaching.md)
- [_includes/vita_cv.html](_includes/vita_cv.html)
- [_includes/vita_papers.html](_includes/vita_papers.html)
- [_includes/vita_teaching.html](_includes/vita_teaching.html)
- [_sass/_page.scss](_sass/_page.scss)

The page files are intentionally short. The includes render the repeated HTML, and the SCSS controls font size and spacing.

## Ruby Note

I recommend installing Ruby 3 only through Homebrew or a Ruby version manager, not by replacing macOS's system Ruby. That is low risk: other Mac programs can keep using the system Ruby, while this website uses the newer Ruby when you open this project.

## How This Works

The trick is that repeated CV information now lives once, in [_data/cv.yml](_data/cv.yml). Jekyll reads that file for the website pages, and [scripts/build_cv.rb](scripts/build_cv.rb) reads the same file to rebuild the LaTeX CV and PDF.

The website pages stay as simple Markdown shells, while the repeated rendered pieces are HTML includes. That gives better spacing and layout control than large Markdown lists, without making routine CV updates harder.
