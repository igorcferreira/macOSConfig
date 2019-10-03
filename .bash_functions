# Forcefully cleans Derived Data
function kill_dd() {
	killall Xcode
	rm -rf ~/Library/Developer/Xcode/DerivedData
	open -a Xcode
}

function kill_beta_dd() {
	killall Xcode
	rm -rf ~/Library/Developer/Xcode-beta/DerivedData
	open -a Xcode-beta
}

function dump_apk_header() {
	BUILD_TOOL="$(ls -tU $ANDROID_HOME/build-tools | head -1)"
	APK_PATH="$1"
	"$ANDROID_HOME/build-tools/$BUILD_TOOL/aapt2" dump badging $APK_PATH
}

# Looks for the app of an Application
function path_for_app() {
	NAME_APP=$1
	PATH_LAUNCHSERVICES="/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister"
	${PATH_LAUNCHSERVICES} -dump | grep -o "/.*${NAME_APP}.app" | grep -v -E "Caches|TimeMachine|Temporary|/Volumes/${NAME_APP}" | uniq
}


function launch_freeswtich() {
	/usr/local/freeswitch/bin/freeswitch
}

# Nukes all Xcode cache folders
function kill_all() {
	killall Xcode
	rm -rf ~/Library/Developer/Xcode/DerivedData
	rm -rf ~/Library/Developer/Xcode/Archives
	rm -rf ~/Library/Developer/Xcode/iOS\ DeviceSupport
	rm -rf ~/Library/Caches/com.apple.dt.Xcode
	xcrun simctl delete unavailable
}

# Install a git alias that allow you to list git history by running `git adog`
function install_adog() {
	CONFIGURATION=""
	if [ -z "$1" ]; then
		CONFIGURATION="--local"
	else
		CONFIGURATION="$1"
	fi

	echo "git config $CONFIGURATION alias.adog \"log --all --decorate --oneline --graph\""
	git config "$CONFIGURATION" alias.adog "log --all --decorate --oneline --graph"
}

# This method looks to the latest change in a specific line, and shows the history before that line
function git_log_blame_line() {
	if [ -z "$1" -o -z "$2" ]; then
		echo "Usage: $0 [line] [file]"
	else
		BLAME="$(git blame -L $1,$1 $2)"
		COMMIT="$(echo $BLAME | grep -o '[A-Za-z0-9]\{1,\}' | head -1)"
		git log --decorate --graph "$COMMIT"
	fi
}

# This method iterates the submodules and check if there is any submodule that needs to be pushed
function check_submodule_status() {
	CURRENT_PATH="$PWD"

	if [ ! -f "$CURRENT_PATH/.gitmodules" ]; then
		echo "$CURRENT_PATH/.gitmodules is not a root git folder, or .gitmodules files do not exist."
		return 1
	fi

	for SUBMODULE in $(git config --file "$CURRENT_PATH/.gitmodules" --get-regexp path | cut -d " " -f 2); do
		FULL_PATH="$CURRENT_PATH/$SUBMODULE"
		if [ -d "$FULL_PATH" ]; then
			git_check_status "$FULL_PATH"
		fi
	done
}


# Creates a list of all submodules in the git
function git_list_submodules() {
	CURRENT_PATH="$PWD"
	for SUBMODULE in $(git config --file .gitmodules --get-regexp path | cut -d " " -f 2); do
		FULL_PATH="$CURRENT_PATH/$SUBMODULE"
		if [ -d "$FULL_PATH" ]; then
			echo "$FULL_PATH"
		fi
	done
}

# This updates all the outdated gems in the gemspec
function gem_update_all() {
	for element in $(gem outdated | cut -d ' ' -f 1); do
		echo "Updating ${element}"
		gem update "${element}"
	done
}

# This method checks the status of a git repo, and indicates if there is any change to be pushed
function git_check_status() {

	CLEAR_MESSAGE="working tree clean"

	if [ ! -z "$1" ]; then
		GIT_PATH="$1"
		STATUS_CALL="LANG=en_GB git -C \"$1\" status"
	else
		GIT_PATH="$PWD"
		STATUS_CALL="LANG=en_GB git status"
	fi

	if [ ! -d "$GIT_PATH" ]; then
		echo "$GIT_PATH is not a folder. Usage: $0 [path]"
		return 1
	else
		STATUS_RESULT=$(eval "$STATUS_CALL")
	fi

	if [[ $(eval "echo \"$STATUS_RESULT\" | grep -op \"$CLEAR_MESSAGE\"") == "$CLEAR_MESSAGE" ]]; then
		echo "Path $GIT_PATH is OK"
		return 0
	else
		echo "Path $GIT_PATH is not OK:"
		echo "$STATUS_RESULT"
		return 1
	fi
}

# This method helps to move all branches from one remote to another
function move_repo() {
	if [[ -z "$3" ]]; then
		echo "Missing initial/default branch"
		echo "The current use of the command is:"
		echo "$0 [source remote] [destination remote] [default branch]"
		exit 1
	fi

	if [[ ! -z "$4" ]]; then
		echo "Missing initial/default branch"
		echo "The current use of the command is:"
		echo "$0 [source remote] [destination remote] [default branch]"
		exit 1
	fi

	for branch in $(git branch -r | grep "$1/" | sed "s/$1\///g" | grep -v "HEAD" | grep -v "$3"); do
		eval "git checkout $branch $1/$branch && git push $2 $branch && git checkout $3 && git branch -D $branch"
	done
}

# This method runs the git clone, and already updates all submodules
function git_clone_submodules() {
	git clone "$@"
	git submodule update --init --recursive
}

# This method fixes the broken call to start an android emulator
function open_avd_emulator() {
	if [ -z "$1" ]; then
		echo "Usage: $0 <Emulator name>"
		echo "You can run 'emulator -list-avds' to check the installed emulators."
		echo "Current emulators available:"
		emulator -list-avds
		return 1
	fi

	$ANDROID_HOME/tools/emulator -avd "$1"
}