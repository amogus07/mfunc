# mfunc - meta function plugin for oh-my-zsh
#
# a wrapper for easier use of zshell's functions/autoload capabilities
#
# hlohm 2015
# github.com/hlohm
##################

# this is where our functions live
[[ -v MFUNCDIR ]] ||
    MFUNCDIR="${HOME}/.functions" &&
    [[ -v ZDOTDIR ]] &&
        MFUNCDIR="${ZDOTDIR}/functions"
	

# check if functions directory exists, create if it doesn't
[[ -d "${MFUNCDIR}/" ]] || {
    mkdir "${MFUNCDIR}/" &&
        echo "mfunc init: functions directory created in $MFUNCDIR" ||
        return
}

# check if fpath contains MFUNC_FUNCTIONS_D, add it if it doesn't
MFUNC_FUNCTIONS_D="${0:h}/functions"
(( ${fpath[(I)$MFUNC_FUNCTIONS_D]} )) || fpath=($MFUNC_FUNCTIONS_D "${fpath[@]}")

# check if fpath contains our MFUNCDIR, add it if it doesn't
(( ${fpath[(I)$MFUNCDIR]} )) || fpath=($MFUNCDIR "${fpath[@]}")

# autoload functions
files=($MFUNC_FUNCTIONS_D/* $MFUNCDIR/*)
autoload ${(z)files[@]:t}
