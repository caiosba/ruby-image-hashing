top_srcdir=/home/caiosba/SaferNet/FacebookHackathonUK2019/vips/vips-8.8.4
PYTHON=
# we need a different tmp for each script since make can run tests in parallel
tmp=$top_srcdir/test/tmp-$$
test_images=$top_srcdir/test/test-suite/images
image=$test_images/йцук.jpg
mkdir -p $tmp
vips=$top_srcdir/tools/vips
vipsthumbnail=$top_srcdir/tools/vipsthumbnail
vipsheader=$top_srcdir/tools/vipsheader

# we need bc to use '.' for a decimal separator
export LC_NUMERIC=C
