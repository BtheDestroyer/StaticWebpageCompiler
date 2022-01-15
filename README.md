# StaticWebpageCompiler

Simple shell script for constructing a static webpage from multiple HTML documents.

## Included example

The included example is based on the "Dimension" template by [HTML5 UP](https://html5up.net/dimension) and is based off the repository for [my own website](https://brycedixon.dev/).

The included example also includes a `netlify.toml` file which can be used by sites hosted by [Netlify](https://www.netlify.com/) to automatically run the compiler whenever a new commit is made.

## How to Use

1. Edit `TEMPLATE_FILES` in `build.sh` to add or remove sections. The order of the provided templates will determine how they are ordered in the final output.

2. Edit the files within `./template/` the names provided to `TEMPLATE_FILES` in the above step (eg: `about.html`; aka: 'template files') to appear as you'd like.

3. To build a template out of multiple files, create a folder in the root directory named the same as one of your template files (eg: `./experience/`; aka: 'template folders') and that template file will be constructed automatically from all of the files in that folder in reverse alphabetical order.

  - For example, the files in `./experience/` will be concatenated in order (`99.Header.html`, ..., `01.Project1.html`, `00.Footer.html`) into `./template/experience.html`.
  
  - This allows for certain sections (like work experience or project history) to grow over time while remaining in chronological order with the newest entries at the top.

4. If a `build.sh` file (aka: 'subscripts') is found within a template folder (eg: `./blog/build.sh`) it will be run to generate the output of that template folder. This can be useful for more complex sections of your page. Subscripts should write to the file `$INTERMEDIARY_OUTPUT` which will be then read by the main build script.

  - For example, `./blog/` contains many sub-sections which contain metadata such as their section title and relevant tags, so a subscript is used to dynamically construct the table-of-contents (aka: "post index") followed by each post.

5. Images, CSS, JavaScript, and other static files can be put in the `./static/` folder to be accessed as though `./static/` is the root of your website.

  - For example, if your website is hosted at `https://brycedixon.dev/` the file `./static/images/bg.png` could be accessed via the path `/images/bg.png`

6. Optional, but recommended: Add lines to the `./.gitignore` for the output template file of every template folder you're using.

  - For example, the template folders `./blog/` and `./experience/` will be used to build the template files `./template/blog.html` and `./template/experience.html`, so those files should be added to the `./.gitignore`.

  - This isn't strictly necessary, but because those files will be regenerated every time the script is run, they don't need to be stored in the repository.
