# QA/SDET Test Automation Project Generator
# This script creates a new Serenity Cucumber BDD test automation project structure

param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectName,
    
    [Parameter(Mandatory=$false)]
    [string]$BasePackage = "com.company.automation",
    
    [Parameter(Mandatory=$false)]
    [string]$ProjectPath = ".",
    
    [Parameter(Mandatory=$false)]
    [string]$JavaVersion = "11"
)

# Function to create directory if it doesn't exist
function New-DirectoryIfNotExists {
    param([string]$Path)
    if (!(Test-Path $Path)) {
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
        Write-Host "Created directory: $Path" -ForegroundColor Green
    }
}

# Function to create file with content
function New-FileWithContent {
    param(
        [string]$Path,
        [string]$Content
    )
    $Content | Out-File -FilePath $Path -Encoding UTF8
    Write-Host "Created file: $Path" -ForegroundColor Green
}

Write-Host "Creating QA/SDET Test Automation Project: $ProjectName" -ForegroundColor Cyan

# Create project root directory
$projectRoot = Join-Path $ProjectPath $ProjectName
New-DirectoryIfNotExists $projectRoot

# Create Maven project structure
$srcMainJava = Join-Path $projectRoot "src\main\java"
$srcTestJava = Join-Path $projectRoot "src\test\java"
$srcTestResources = Join-Path $projectRoot "src\test\resources"

# Main source directories
New-DirectoryIfNotExists (Join-Path $srcMainJava "pages\common")
New-DirectoryIfNotExists (Join-Path $srcMainJava "pages\login")
New-DirectoryIfNotExists (Join-Path $srcMainJava "pages\dashboard")
New-DirectoryIfNotExists (Join-Path $srcMainJava "api\clients")
New-DirectoryIfNotExists (Join-Path $srcMainJava "api\models")
New-DirectoryIfNotExists (Join-Path $srcMainJava "api\responses")
New-DirectoryIfNotExists (Join-Path $srcMainJava "utils\database")
New-DirectoryIfNotExists (Join-Path $srcMainJava "utils\filehandling")
New-DirectoryIfNotExists (Join-Path $srcMainJava "utils\testdata")
New-DirectoryIfNotExists (Join-Path $srcMainJava "config")

# Test source directories
New-DirectoryIfNotExists (Join-Path $srcTestJava "stepdefinitions")
New-DirectoryIfNotExists (Join-Path $srcTestJava "runners")
New-DirectoryIfNotExists (Join-Path $srcTestJava "hooks")

# Test resources directories
New-DirectoryIfNotExists (Join-Path $srcTestResources "features\login")
New-DirectoryIfNotExists (Join-Path $srcTestResources "features\dashboard")
New-DirectoryIfNotExists (Join-Path $srcTestResources "testdata")
New-DirectoryIfNotExists (Join-Path $srcTestResources "config")

# Create pom.xml
$pomContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 
         http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>$BasePackage</groupId>
    <artifactId>$ProjectName</artifactId>
    <version>1.0.0</version>
    <packaging>jar</packaging>

    <name>$ProjectName Test Automation</name>
    <description>Serenity Cucumber BDD Test Automation Project</description>

    <properties>
        <maven.compiler.source>$JavaVersion</maven.compiler.source>
        <maven.compiler.target>$JavaVersion</maven.compiler.target>
        <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
        
        <!-- Dependency Versions -->
        <serenity.version>3.9.8</serenity.version>
        <serenity.cucumber.version>3.9.8</serenity.cucumber.version>
        <cucumber.version>7.14.0</cucumber.version>
        <rest.assured.version>5.3.2</rest.assured.version>
        <selenium.version>4.15.0</selenium.version>
        <testng.version>7.8.0</testng.version>
        <logback.version>1.4.11</logback.version>
    </properties>

    <dependencies>
        <!-- Serenity BDD -->
        <dependency>
            <groupId>net.serenity-bdd</groupId>
            <artifactId>serenity-core</artifactId>
            <version>`${serenity.version}</version>
        </dependency>
        
        <dependency>
            <groupId>net.serenity-bdd</groupId>
            <artifactId>serenity-cucumber</artifactId>
            <version>`${serenity.cucumber.version}</version>
        </dependency>
        
        <dependency>
            <groupId>net.serenity-bdd</groupId>
            <artifactId>serenity-rest-assured</artifactId>
            <version>`${serenity.version}</version>
        </dependency>

        <!-- Cucumber -->
        <dependency>
            <groupId>io.cucumber</groupId>
            <artifactId>cucumber-java</artifactId>
            <version>`${cucumber.version}</version>
        </dependency>

        <!-- Selenium WebDriver -->
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-java</artifactId>
            <version>`${selenium.version}</version>
        </dependency>

        <!-- REST Assured -->
        <dependency>
            <groupId>io.rest-assured</groupId>
            <artifactId>rest-assured</artifactId>
            <version>`${rest.assured.version}</version>
        </dependency>

        <!-- TestNG -->
        <dependency>
            <groupId>org.testng</groupId>
            <artifactId>testng</artifactId>
            <version>`${testng.version}</version>
        </dependency>

        <!-- Logging -->
        <dependency>
            <groupId>ch.qos.logback</groupId>
            <artifactId>logback-classic</artifactId>
            <version>`${logback.version}</version>
        </dependency>
    </dependencies>

    <build>
        <plugins>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-compiler-plugin</artifactId>
                <version>3.11.0</version>
                <configuration>
                    <source>`${maven.compiler.source}</source>
                    <target>`${maven.compiler.target}</target>
                </configuration>
            </plugin>

            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-surefire-plugin</artifactId>
                <version>3.1.2</version>
                <configuration>
                    <testFailureIgnore>true</testFailureIgnore>
                </configuration>
            </plugin>

            <plugin>
                <groupId>net.serenity-bdd.maven.plugins</groupId>
                <artifactId>serenity-maven-plugin</artifactId>
                <version>`${serenity.version}</version>
                <executions>
                    <execution>
                        <id>serenity-reports</id>
                        <phase>post-integration-test</phase>
                        <goals>
                            <goal>aggregate</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
</project>
"@

New-FileWithContent (Join-Path $projectRoot "pom.xml") $pomContent

# Create serenity.properties
$serenityPropsContent = @"
# Serenity Configuration
serenity.project.name=$ProjectName Test Automation
serenity.test.root=stepdefinitions

# WebDriver Configuration
webdriver.driver=chrome
webdriver.chrome.driver=
chrome.switches=--disable-gpu,--no-sandbox,--disable-dev-shm-usage

# Timeouts
webdriver.timeouts.implicitlywait=5000
webdriver.wait.for.timeout=10000

# Screenshots
serenity.take.screenshots=BEFORE_AND_AFTER_EACH_STEP
serenity.keep.unscaled.screenshots=true

# Reporting
serenity.report.encoding=UTF8
serenity.verbose=true

# Restart browser
serenity.restart.browser.for.each=scenario

# Test Data
test.data.dir=src/test/resources/testdata
"@

New-FileWithContent (Join-Path $projectRoot "serenity.properties") $serenityPropsContent

# Create TestNG configuration
$testngContent = @"
<?xml version="1.0" encoding="UTF-8"?>
<suite name="$ProjectName Test Suite" parallel="classes" thread-count="3">
    <test name="Regression Tests">
        <classes>
            <class name="runners.RegressionTestRunner"/>
        </classes>
    </test>
    
    <test name="Smoke Tests">
        <classes>
            <class name="runners.SmokeTestRunner"/>
        </classes>
    </test>
</suite>
"@

New-FileWithContent (Join-Path $projectRoot "testng.xml") $testngContent

# Create sample feature file
$sampleFeatureContent = @"
@login @smoke
Feature: User Login
  As a registered user
  I want to login to the application
  So that I can access my account

  Background:
    Given I am on the login page

  @critical @happy_path
  Scenario: Successful login with valid credentials
    Given I have valid user credentials
    When I enter my username and password
    And I click the login button
    Then I should be redirected to the dashboard
    And I should see a welcome message

  @negative @error_handling
  Scenario Outline: Login with invalid credentials
    When I enter "<username>" and "<password>"
    And I click the login button
    Then I should see an error message "<error_message>"

    Examples:
      | username      | password    | error_message           |
      | invalid_user  | valid_pass  | Invalid username        |
      | valid_user    | invalid_pass| Invalid password        |
      | empty         | valid_pass  | Username is required    |
      | valid_user    | empty       | Password is required    |
"@

New-FileWithContent (Join-Path $srcTestResources "features\login\login.feature") $sampleFeatureContent

Write-Host "`nProject structure created successfully!" -ForegroundColor Green
Write-Host "Project location: $projectRoot" -ForegroundColor Yellow
Write-Host "`nNext steps:" -ForegroundColor Cyan
Write-Host "1. Navigate to project directory: cd '$projectRoot'" -ForegroundColor White
Write-Host "2. Import project into your IDE" -ForegroundColor White
Write-Host "3. Update serenity.properties with your application URLs" -ForegroundColor White
Write-Host "4. Create your page objects and step definitions" -ForegroundColor White
Write-Host "5. Run tests: mvn clean test serenity:aggregate" -ForegroundColor White