#!/usr/bin/env ruby

require "fileutils"
require "yaml"

ROOT = File.expand_path("..", __dir__)
DATA_PATH = File.join(ROOT, "_data", "cv.yml")
FILES_DIR = File.join(ROOT, "files")
TEX_PATH = File.join(FILES_DIR, "main_CV.tex")

def latex_escape(value)
  replacements = {
    "\\" => "\\textbackslash{}",
    "&" => "\\&",
    "%" => "\\%",
    "$" => "\\$",
    "#" => "\\#",
    "_" => "\\_",
    "{" => "\\{",
    "}" => "\\}",
    "~" => "\\textasciitilde{}",
    "^" => "\\textasciicircum{}"
  }

  value.to_s.gsub(/[\\&%$#_{}~^]/) { |character| replacements.fetch(character) }
end

def linked_title(item)
  title = "\\textbf{#{latex_escape(item.fetch("title"))}}"
  return title unless item["url"]

  "\\href{#{item.fetch("url")}}{#{title}}"
end

def paper_item(item)
  line = linked_title(item)
  line += " (with #{latex_escape(item["authors"])})" if item["authors"]
  notes = Array(item["notes"])

  output = ["\\item[$\\bullet$] #{line}"]
  unless notes.empty?
    output << "\\begin{itemize}"
    notes.each do |note|
      output << "    \\item[-] \\textit{#{latex_escape(note)}}"
    end
    output << "\\end{itemize}"
  end
  output.join("\n")
end

def dated_item(label, dates)
  "    \\item #{latex_escape(label)} \\hfill #{latex_escape(dates)}"
end

def render_paper_section(title, items)
  <<~TEX
  % ----------------------------------------
  \\section{#{latex_escape(title)}}
  % ----------------------------------------

  \\begin{itemize}[itemsep=1.3em]
  #{items.map { |item| paper_item(item) }.join("\n\n")}
  \\end{itemize}
  TEX
end

def run_command(*command)
  system(*command, chdir: FILES_DIR, out: $stdout, err: $stderr)
end

def executable?(name)
  ENV.fetch("PATH", "").split(File::PATH_SEPARATOR).any? do |directory|
    path = File.join(directory, name)
    File.file?(path) && File.executable?(path)
  end
end

data = YAML.load_file(DATA_PATH)
profile = data.fetch("profile")
research = data.fetch("research")

tex = <<~TEX
\\documentclass{article}[12]

\\usepackage{geometry}
\\usepackage{tgpagella}
\\usepackage{titlesec}
\\usepackage{fancyhdr}
\\usepackage[yyyymmdd]{datetime}
\\usepackage{tabularx}
\\usepackage{xcolor}
\\usepackage{enumitem}
\\usepackage{hyperref}

\\titleformat{\\section}[display]{\\Large\\scshape}{}{0ex}{}[\\vspace{-2ex}\\rule{\\textwidth}{0.3pt}]
\\titlespacing{\\section}{0pc}{-3ex plus .1ex minus .1ex}{0pc}[0pc]

\\geometry{
  body={6.5in, 9.0in},
  left=.75in,
  right=0.85in,
  bottom=0.8in,
  top=0.8in
}

\\setlist[itemize]{leftmargin=0.0em, itemsep=0.0em, topsep=0.0em, label={}, parsep=0.35em}
\\setlist[itemize,2]{leftmargin=2.0em, itemsep=-.35em}

\\pagestyle{fancy}
\\renewcommand{\\headrulewidth}{0pt}
\\cfoot{}
\\rhead{\\emph{}}

\\setlength{\\parskip}{1.1ex}
\\setlength\\parindent{0pt}
\\newdateformat{mydate}{\\monthname[\\THEMONTH] \\THEYEAR}
\\definecolor{RiceBlue}{RGB}{0,82,147}
\\urlstyle{same}
\\newcommand{\\email}[1]{\\href{mailto:#1}{#1}}
\\renewcommand{\\labelitemi}{$\\bullet$}

\\newcommand{\\myname}{#{latex_escape(profile.fetch("name"))}}
\\newcommand{\\myemail}{#{latex_escape(profile.fetch("email"))}}
\\newcommand{\\mywebsite}{#{profile.fetch("website")}}
\\newcommand{\\myphone}{#{latex_escape(profile.fetch("phone"))}}
\\newcommand{\\myaddress}{#{latex_escape(profile.fetch("address"))}}
\\newcommand{\\updated}{(Updated: \\mydate\\today)}

\\newcommand{\\linkcolor}{black}
\\hypersetup{
  colorlinks=true,
  linkcolor={\\linkcolor},
  filecolor={\\linkcolor},
  urlcolor={\\linkcolor},
  pdfauthor={\\myname},
  pdfsubject={Curriculum Vitae},
  pdftitle={\\myname: Curriculum Vitae},
  pdfpagemode=UseNone,
}

\\begin{document}
\\thispagestyle{empty}

\\begin{center}
{\\bfseries\\Large\\scshape \\myname} \\\\[4pt]
\\email{\\myemail} \\\\ \\url{\\mywebsite} \\\\ \\myaddress \\\\ \\myphone \\\\ \\smallskip \\updated
\\end{center}

\\vspace{-0.5cm}

% ----------------------------------------
\\section{Academic Employment}
% ----------------------------------------

\\begin{itemize}[itemsep=0.25em]
#{data.fetch("employment").map { |item| dated_item(item.fetch("title"), item.fetch("dates")) }.join("\n")}
\\end{itemize}

\\vspace{-0.5cm}

% ----------------------------------------
\\section{Education}
% ----------------------------------------

\\begin{itemize}[itemsep=0.25em]
#{data.fetch("education").map { |item| dated_item(item.fetch("degree"), item.fetch("dates")) }.join("\n")}
\\end{itemize}

\\vspace*{0.1cm}

#{render_paper_section("Published Research", research.fetch("published"))}

#{render_paper_section("Working Papers", research.fetch("working"))}

#{render_paper_section("Work In Progress", research.fetch("work_in_progress"))}

% ----------------------------------------
\\section{Teaching}
% ----------------------------------------

\\begin{itemize}[itemsep=0.005em]
#{data.fetch("teaching").map do |school|
  lines = ["    \\item \\textbf{#{latex_escape(school.fetch("school"))}}"]
  lines << "    \\begin{itemize}"
  if school["courses"]
    lines << "        \\item[$\\bullet$] \\textbf{Courses}"
    lines << "        \\begin{itemize}"
    school.fetch("courses").each do |course|
      label = latex_escape(course.fetch("name"))
      label += " (Student evaluation: #{latex_escape(course["evaluation"])})" if course["evaluation"]
      lines << "            \\item[-] #{label}"
    end
    lines << "        \\end{itemize}"
  end
  if school["awards"]
    lines << "        \\item[$\\bullet$] \\textbf{Teaching Awards}"
    lines << "        \\begin{itemize}[leftmargin=0.5cm]"
    school.fetch("awards").each do |award|
      lines << "            \\item[-] \\textit{#{latex_escape(award)}}"
    end
    lines << "        \\end{itemize}"
  end
  lines << "    \\end{itemize}"
  lines.join("\n")
end.join("\n\n")}
\\end{itemize}

% ----------------------------------------
\\section{Professional Activities}
% ----------------------------------------

\\begin{itemize}[itemsep=0.5em]
    \\item \\textbf{#{latex_escape(data.fetch("professional_activities").fetch("conference_heading"))}}
    \\begin{itemize}
#{data.fetch("professional_activities").fetch("conferences").map { |conference| "        \\item \\textbf{#{latex_escape(conference.fetch("year"))}:} #{latex_escape(conference.fetch("items"))}" }.join("\n")}
    \\end{itemize}

    \\item \\textbf{#{latex_escape(data.fetch("professional_activities").fetch("referee_heading"))}:}
    \\begin{itemize}[itemsep=0.005em]
        \\item #{latex_escape(data.fetch("professional_activities").fetch("referees"))}
    \\end{itemize}
\\end{itemize}

% ----------------------------------------
\\section{Scholarships, Honors, and Awards}
% ----------------------------------------

\\begin{itemize}[itemsep=0.05em]
#{data.fetch("awards").map { |item| dated_item(item.fetch("title"), item.fetch("dates")) }.join("\n")}
\\end{itemize}

\\end{document}
TEX

FileUtils.mkdir_p(FILES_DIR)
File.write(TEX_PATH, tex)
puts "Wrote #{TEX_PATH}"

unless ARGV.include?("--no-pdf")
  compiled = if executable?("latexmk")
    run_command("latexmk", "-pdf", "-interaction=nonstopmode", "-halt-on-error", "main_CV.tex")
  elsif executable?("pdflatex")
    run_command("pdflatex", "-interaction=nonstopmode", "-halt-on-error", "main_CV.tex") &&
      run_command("pdflatex", "-interaction=nonstopmode", "-halt-on-error", "main_CV.tex")
  else
    warn "No LaTeX compiler found. TeX was updated, but PDF was not rebuilt."
    false
  end

  if compiled
    FileUtils.rm_f(Dir[File.join(FILES_DIR, "main_CV.{aux,log,out,fls,fdb_latexmk,synctex.gz}")])
    puts "Wrote #{File.join(FILES_DIR, "main_CV.pdf")}"
  end
end