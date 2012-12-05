
filename = "/etc/sudoers"

### Creating backup of sudoers ######
backup = "/opt/sudoers_backup"
input = File.open(filename)
indata = input.read()
output = File.open(backup, 'w')
output.write(indata)
output.close()
input.close()

### Updating the sudoers with nrpe #####
target = File.open(filename, 'a+')
line1 = "Defaults:nrpe !requiretty"
line2 = "nrpe 	ALL =(ALL)	 NOPASSWD: ALL"
target.puts(line1)
target.puts(line2)
target.close()
