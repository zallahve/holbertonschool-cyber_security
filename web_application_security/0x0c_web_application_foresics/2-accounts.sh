#!/bin/bash
tail -n 1000 * 2>/dev/null | awk '
/Failed password/ {
    for (i = 1; i <= NF; i++) {
        if ($i == "for") {
            if ($(i + 1) == "invalid" && $(i + 2) == "user")
                user = $(i + 3)
            else
                user = $(i + 1)
            failed[user]++
        }
    }
}

/Accepted/ {
    for (i = 1; i <= NF; i++) {
        if ($i == "for") {
            success[$(i + 1)]++
        }
    }
}

END {
    best = ""
    max = -1

    for (user in success) {
        if (failed[user] > max) {
            max = failed[user]
            best = user
        }
    }

    print best
}
'
