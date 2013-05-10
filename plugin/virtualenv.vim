python << EOF
import os
virtualenvs_path = os.environ.get("VIRTUALENVS")
if virtualenvs_path:
    activate_this = os.path.join(virtualenvs_path, "vim", "bin", "activate_this.py")
    if os.path.exists(activate_this):
        execfile(activate_this, dict(__file__=activate_this))
EOF
