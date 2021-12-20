#!/usr/bin/bash
files=()
seen_double=
last_arg=
for arg; do
    case "$last_arg" in
        o) output="$arg"; last_arg=; continue ;;
        '') ;;
    esac

    case "$arg" in
        '-'*) if [[ -n "$seen_double" ]]; then
            files+=("$arg")
        else
            case "$arg" in
                '--') seen_double=1 ;;
                '-h'|'--help')
                    printf >&2 'usage: %s [-o encrypted] [--] PATH...|FILES... encrypted\n' "$0"
                    exit 1
                ;;
                -o|--output)
                    last_arg=o
                ;;
            esac
        fi
        ;;
        *) files+=("$arg") ;;
    esac
done

if (( ${#files[@]} < 2 )) && [[ -z "$output" ]]; then
    echo "Not enough files or paths given!"
    echo "Need at least one file or path and one destination."
    echo "See --help"
    exit 1
elif (( ${#files[@]} == 0 )); then
    files=(.)
fi

if [[ -z "$output" ]]; then
    output="${files[-1]}"
    files=("${files[@]:0:${#files[@]}-1}")
fi

# *do not* compress given directory to a custom named archive
# SEE: https://crypto.stackexchange.com/questions/29972/is-there-an-existing-cryptography-algorithm-method-that-both-encrypts-and-comp/29974#29974
tar -cvf - --exclude="$output.gpg" -- "${files[@]}" \
| gpg2 --symmetric --output "$output".gpg -- -
