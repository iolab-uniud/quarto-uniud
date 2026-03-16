#import "/_extensions/iolab-uniud/uniud/uniud-notes.typ": uniud-notes

#show: uniud-notes.with(
$if(title)$  title:    [$title$],$endif$
$if(subtitle)$  subtitle: [$subtitle$],$endif$
$if(date)$  date:     [$date$],$endif$
$if(course)$  course:   [$course$],$endif$
  authors: (
$for(by-author)$
    (
      name:  "$it.name.literal$"
$if(it.email)$      , email: "$it.email$"$endif$
    ),
$endfor$
  ),
)