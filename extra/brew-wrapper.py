# coding: utf-8

from __future__ import print_function
from __future__ import unicode_literals

import os
import subprocess
import sys

SKIP_FORMULAS = ["mongodb", "mysql", "delve", "go-delve/delve/delve", "gawk",
                 "gnu-sed", "gnupg21", "homebrew/versions/gnupg21", "bash",
                 "pinentry-mac", "terraform", "packer", "go"]


def invoke_brew(args):
    cmd = [os.environ["BREW_PATH"]]
    cmd.extend(args)
    sys.exit(subprocess.call(cmd))


def brew_action(args):
    for arg in args:
        if not arg.startswith("-"):
            return arg


def count_args(args):
    return len([a for a in args if not a.startswith("-")])


def filter_args(args):
    filtered = []
    for a in args:
        if a in SKIP_FORMULAS:
            sys.stderr.write("WARNING: skiping {}. Use package manager to install it\n".format(a))
            continue
        filtered.append(a)
    if count_args(filtered) == 1:
        sys.exit(3)
    return filtered


def main(args):
    action = brew_action(args)
    if action == "install":
        args = filter_args(args)
    invoke_brew(args)

if __name__ == "__main__":
    main(sys.argv[1:])
