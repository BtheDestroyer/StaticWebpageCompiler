#!/bin/bash
echo "" > "${INTERMEDIARY_OUTPUT}"
# Post list
echo "  Building post index..."
cat "Header.html" >> "${INTERMEDIARY_OUTPUT}"
for post in `ls -rd ./posts/*/`; do
  if [ "$post" = "./posts/WIP/" ]; then
    echo "    Ignoring in progress post..."
  else
    TITLE=`cat ${post}title.txt`
    DATE=(${post//[\/\.]/ })
    DATE=`date -d"${DATE[@]:2:1}/${DATE[@]:3:1}/${DATE[@]:1:1}" +"%B %d, %Y"`
    DATE="${DATE// 0/ }"
    POST_ID=${TITLE//[ :\!\@\#\$\%\^\&\*\(\)\\\/?<>\,\.\-\=\+]/_}
    echo "    ${TITLE}..."
    echo "<h2><a href=\"#blog-${POST_ID}\">${TITLE}</a></h2>" >> "${INTERMEDIARY_OUTPUT}"
    for tag in `cat ${post}tags.txt`; do
      echo "<code>${tag}</code>" >> "${INTERMEDIARY_OUTPUT}"
    done
    echo "<h4>${DATE}</h4>" >> "${INTERMEDIARY_OUTPUT}"
    echo "<hr />" >> "${INTERMEDIARY_OUTPUT}"
  fi
done
cat "Footer.html" >> "${INTERMEDIARY_OUTPUT}"

# Each post
echo "  Building posts..."
for post in `ls -rd ./posts/*/`; do
  if [ "$post" = "./posts/WIP/" ]; then
    echo "    Ignoring in progress posts..."
  else
    TITLE=`cat ${post}title.txt`
    DATE=(${post//[\/\.]/ })
    DATE=`date -d"${DATE[@]:2:1}/${DATE[@]:3:1}/${DATE[@]:1:1}" +"%B %d, %Y"`
    DATE="${DATE// 0/ }"
    POST_ID=${TITLE//[ :\!\@\#\$\%\^\&\*\(\)\\\/?<>\,\.\-\=\+]/_}
    echo "    ${TITLE}..."
    echo "<article id=\"blog-${POST_ID}\">" >> "${INTERMEDIARY_OUTPUT}"
    echo "<h2>${TITLE}</h2>" >> "${INTERMEDIARY_OUTPUT}"
    echo "<h4>${DATE}</h4>" >> "${INTERMEDIARY_OUTPUT}"
    echo "<hr />" >> "${INTERMEDIARY_OUTPUT}"
    cat ${post}/Content.html >> "${INTERMEDIARY_OUTPUT}"
    echo "<a href=\"#blog\" class=\"button\">Back</a>" >> "${INTERMEDIARY_OUTPUT}"
    echo "</article>" >> "${INTERMEDIARY_OUTPUT}"
  fi
done
