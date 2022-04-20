# if our internal toolchain is installed, make sure the
# updater scripts are in our path
if [ -d ~/.msrustup/bin ] ; then
    export PATH="$HOME/.msrustup/bin:$PATH"
fi
