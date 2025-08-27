from pathlib import Path
import sys
import os
class ProfileException:
    def __init__(self):
        self.name = ""
        self.mode = ""
        self.entries = []
    def parse(self, path):
        fp = open(path)
        if fp == None:
            print("Attempt to load inaccessible file: " + path)
            sys.exit(1)
        path = os.path.basename(path)
        self.name = path.strip().split("_")[0]
        self.mode = path.strip().split("_")[1]
        for l in fp.readlines():
            self.entries.append(l.strip("\n"))
class ProfileExceptionList:
    def __init__(self, path):
        # name: exception
        self.entries = {}
        self.path = path
    def addException(self, filename):
        cur_exc = ProfileException()
        cur_exc.parse(self.path + filename)
        # Eventually it may make sense to consolidate modes into one object, but we
        # maintain them seperately for now
        self.entries[cur_exc.name + "_" + cur_exc.mode] = cur_exc
    def parse(self):
        for filename in os.listdir(self.path):
            self.addException(filename)
#
# This parses a text file of default values, makes sure the entry exists in pel, then
# links to it so defaults can be covered.
class DefaultList:
    def __init__(self, filename, pel):
        self.file = filename
        self.pel = pel
        self.default_list = []
    # One line, comma sep list of default values
    def loadDefaults(self):
        fp = open(self.file)
        if fp == None:
            print("Couldn't open defaults file: " + self.file)
            sys.exit(1)
        l = fp.readline()
        dlist = l.strip().split(",")
        for e in dlist:
            if e.strip() not in pel.entries:
                print("Entry " + e + " not found in ProfileExceptionList")
                sys.exit(1)
            self.default_list.append(e.strip())
    # Return a list of entries that are not included in exc list
    #
    # This must ignore mode and focus on name
    def findDefaults(self, exc_list):
        found = False
        for default_name in self.default_list:
            # This will get a lot cleaner if/when we consolidate names into singular
            # objects with different modes, for now it's this...
            for exc_name in exc_list:
                name = exc_name.strip().split("_")[0].strip()
                # If we find a name match, we're done here
                if default_name.strip().split("_")[0].strip() == exc_name.strip().split("_")[0].strip():
                    found = True
                    break
            if not found:
                exc_list.append(default_name)
            found = False
        return
#
# Parse the submitted configuration line
#
# servicename.sp:one_enable,two_disable, ...
class ConfigLine:
    def __init__(self, line, defaults, pel):
        self.line = line
        self.defaults = defaults
        self.pel = pel
        self.name = line.strip().split(":")[0]
        self.exempt_list = line.strip().split(":")[1].strip().split(",")
    def generateProfile(self):
        prof_str = "profile " + self.name + " flags=(complain, attach_disconnected, mediate_deleted) {\n"
        # Insert missing defaults
        self.defaults.findDefaults(self.exempt_list)
        # Generate the profile
        for e in self.exempt_list:
            if e not in self.pel.entries:
                print("Config line specifies entry that is invalid: " + e)
                sys.exit(1)
            # Comment out this line if you don't want comments to indicate what file was used
            prof_str += "# " + self.pel.entries[e].name + "_" + self.pel.entries[e].mode + "\n"
            for l in self.pel.entries[e].entries:
                prof_str += l + "\n"
        prof_str += "signal," + "\n"
        prof_str += "ptrace," + "\n"
        prof_str += "capability," + "\n"
        prof_str += "mount," + "\n"
        prof_str += "umount," + "\n"
        prof_str += "/ r," + "\n"
        prof_str += "allow /** pix," + "\n"
        prof_str += "allow /** rwlkm," + "\n"
        prof_str += "}"
        return prof_str
    def getName(self):
        return self.name
def usage():
    print(sys.argv[0] + " <bundle dir> <output dir>")
if __name__ == '__main__':
    bundle_dir = sys.argv[1]
    output_dir = sys.argv[2]
    # Basic validation, we should expand this later TODO
    if not Path(bundle_dir).is_dir():
        print("Please ensure bundle directory is a directory and exists.\n")
        usage()
        sys.exit(-1)
    if not Path(output_dir).is_dir():
        print("Please ensure output directory is a directory and exists.\n")
        usage()
        sys.exit(-1)
    if not Path(bundle_dir + "/config.cfg").is_file():
        print("Bundle is invalid: config.cfg does not exist.")
        sys.exit(-1)
    if not Path(bundle_dir + "/defaults.cfg").is_file():
        print("Bundle is invalid: defaults.cfg does not exist.")
        sys.exit(-1)
    if not Path(bundle_dir + "/exemptions/").is_dir():
        print("Bundle is invalid: exemptions/ dir does not exist")
        sys.exit(-1)
    fp = open(bundle_dir + "/config.cfg", "r")
    for line in fp.readlines():
        # Parse known exemption files
        pel = ProfileExceptionList(bundle_dir + "/exemptions/")
        pel.parse()
        # Parse and verify defaults
        defaults = DefaultList(bundle_dir + "/defaults.cfg", pel)
        defaults.loadDefaults()
        cfg = ConfigLine(line, defaults, pel)
        ofp = open(output_dir + "/" + cfg.name, "w")
        ofp.write(cfg.generateProfile())
        ofp.close()
