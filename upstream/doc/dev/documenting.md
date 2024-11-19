# Documenting Ceph

## User documentation

The documentation on docs.ceph.com is generated from the
reStructuredText sources in `/doc/` in the Ceph git repository.

Please make sure that your changes are written in a way that is intended
for end users of the software, unless you are making additions in
`/doc/dev/`, which is the section for developers.

All pull requests that modify user-facing functionality must include
corresponding updates to documentation: see [Submitting
Patches](https://github.com/ceph/ceph/blob/master/SubmittingPatches.rst)
for more detail.

Check your .rst syntax is working as expected by using the \"View\"
button in the github user interface when looking at a diff on an .rst
file, or build the docs locally using the `admin/build-doc` script.

For more information about the Ceph documentation, see
`/start/documenting-ceph`{.interpreted-text role="doc"}.

## Code Documentation

C and C++ can be documented with [Doxygen](http://www.doxygen.nl/),
using the subset of Doxygen markup supported by
[Breathe](https://github.com/michaeljones/breathe).

The general format for function documentation is

``` c
/**
 * Short description
 *
 * Detailed description when necessary
 *
 * preconditions, postconditions, warnings, bugs or other notes
 *
 * parameter reference
 * return value (if non-void)
 */
```

This should be in the header where the function is declared, and
functions should be grouped into logical categories. The [librados C
API](https://github.com/ceph/ceph/blob/master/src/include/rados/librados.h)
provides a complete example. It is pulled into Sphinx by
[librados.rst](https://github.com/ceph/ceph/raw/master/doc/rados/api/librados.rst),
which is rendered at `/rados/api/librados`{.interpreted-text
role="doc"}.

To generate the doxygen documentation in HTML format use:

    # cmake --build . --target doxygen

HTML output will be under: `build-doc/doxygen/html`

## Drawing diagrams

### Graphviz

You can use [Graphviz](http://graphviz.org/), as explained in the
[Graphviz extension
documentation](https://www.sphinx-doc.org/en/master/usage/extensions/graphviz.html).

::: graphviz

digraph \"example\" {

:   foo -\> bar; bar -\> baz; bar -\> th

}
:::

Most of the time, you\'ll want to put the actual DOT source in a
separate file, like this:

    .. graphviz:: myfile.dot

See the [Dot User\'s Manual](https://www.graphviz.org/pdf/dotguide.pdf)
by Emden R. Gansner, Eleftherios Koutsofios, and Stephen North for
examples of digraphs. This is especially useful if this is your first
time encountering GraphViz.

### Ditaa

You can use [Ditaa](http://ditaa.sourceforge.net/):

::: ditaa
+\-\-\-\-\-\-\-\-\-\-\-\-\--+ /=\-\-\--\| hello, world hi! \|
+\-\-\-\-\-\-\-\-\-\-\-\-\--+ \-\-\-\--/
:::

### Blockdiag

If a use arises, we can integrate [Blockdiag](http://blockdiag.com/en/).
It is a Graphviz-style declarative language for drawing things, and
includes:

-   [block diagrams](http://blockdiag.com/en/blockdiag/): boxes and
    arrows (automatic layout, as opposed to
    [Ditaa](http://ditaa.sourceforge.net/))
-   [sequence diagrams](http://blockdiag.com/en/seqdiag/index.html):
    timelines and messages between them
-   [activity diagrams](http://blockdiag.com/en/actdiag/index.html):
    subsystems and activities in them
-   [network diagrams](http://blockdiag.com/en/nwdiag/): hosts, LANs, IP
    addresses etc (with [Cisco
    icons](https://pypi.org/project/blockdiagcontrib-cisco/) if wanted)

### Inkscape

You can use Inkscape to generate scalable vector graphics.
<https://inkscape.org/en/> for restructuredText documents.

If you generate diagrams with Inkscape, you should commit both the
Scalable Vector Graphics (SVG) file and export a Portable Network
Graphic (PNG) file. Reference the PNG file.

By committing the SVG file, others will be able to update the SVG
diagrams using Inkscape.

HTML5 will support SVG inline.
