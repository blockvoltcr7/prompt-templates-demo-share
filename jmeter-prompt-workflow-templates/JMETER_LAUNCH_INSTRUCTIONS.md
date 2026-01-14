# JMeter GUI Launch Instructions

## Installation Location

JMeter is installed at:
```
/Applications/apache-jmeter-5.6.3
```

## Launching JMeter GUI

### Option 1: From Terminal
Navigate to the JMeter bin directory and run the GUI:
```bash
cd /Applications/apache-jmeter-5.6.3/bin
./jmeter
```

### Option 2: Direct Command
Run from anywhere using the full path:
```bash
/Applications/apache-jmeter-5.6.3/bin/jmeter
```

### Option 3: Using the Shell Script
Run the JMeter shell script directly:
```bash
sh /Applications/apache-jmeter-5.6.3/bin/jmeter.sh
```

### Option 4: Add to PATH (Recommended)
Add JMeter to your PATH for easy access from anywhere:

1. Add this line to your `~/.zshrc` file:
```bash
export PATH="/Applications/apache-jmeter-5.6.3/bin:$PATH"
```

2. Reload your shell configuration:
```bash
source ~/.zshrc
```

3. Now you can launch JMeter from anywhere:
```bash
jmeter
```

## Running in Non-GUI Mode
For performance testing, run JMeter in non-GUI mode:
```bash
/Applications/apache-jmeter-5.6.3/bin/jmeter -n -t test_plan.jmx -l results.jtl
```

## Troubleshooting

If JMeter doesn't launch, ensure you have Java installed:
```bash
java -version
```

JMeter requires Java 8 or higher.
