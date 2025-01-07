Bug Tracking App

google sheet link: https://docs.google.com/spreadsheets/d/11Hu4FtZfXzoEqLt6rtlDQx-7ndE5du-doeuMtPStWkc/edit?gid=2128539032#gid=2128539032

Overview

The Bug Reporter App is a Swift and SwiftUI-based application designed to allow users to report bugs with images and descriptions. The app integrates with Google Sign-In for authentication and uses the Imgur API to upload images. Once a bug is reported, the details are saved in a Google Sheet, including the bug ID, reporter's email, name, image URL, and description. Additionally, the app organizes bug reports into daily sheets. If a sheet tab with the current day's date does not exist, it automatically creates one.

Features
Google Sign-In Integration: Authenticate users using Google Sign-In via Swift Package Manager (SPM).

Bug Reporting: Users can create bug reports with an image and a description.

Image Upload: Images are uploaded to Imgur using the Imgur API, and the returned URL is saved in the Google Sheet.

Google Sheets Integration: Bug reports are saved in a Google Sheet with the following details:

Bug ID

Reporter's Email

Reporter's Name

Image URL

Description

Daily Report Sheets:

Bugs are organized into daily sheets. If a sheet tab with the current day's date (e.g., DD-MM-YY) does not exist, the app automatically creates one.

MVVM Architecture: The app is built using the Model-View-ViewModel (MVVM) pattern.

Clean Architecture: The codebase is structured following Clean Architecture principles for better separation of concerns and maintainability.

Dependencies
Google Sign-In: Integrated via Swift Package Manager (SPM).

Imgur API: Used for uploading images and retrieving image URLs.

Google Sheets API: Used for saving bug reports and managing daily sheets in Google Sheets.

Installation

after clone the repo
Install dependencies via Swift Package Manager:
Go to File > Swift Packages > Resolve Package Versions.


Usage
Sign In:

Launch the app and sign in using your Google account.

Report a Bug:

After signing in, you can create a new bug report.

Add an image and a description for the bug.

Submit Bug:

The image will be uploaded to Imgur, and the bug report will be saved in the Google Sheet.

If a sheet tab with the current day's date (e.g., DD-MM-YYYY) does not exist, the app will automatically create one.

The bug report will include:

Bug ID

Reporter's Email

Reporter's Name

Image URL

Description

Project Structure
The project is structured following the MVVM and Clean Architecture principles:

Models: Contains the data models used in the app.

ViewModels: Contains the ViewModels that handle the business logic and interact with the models.

Views: Contains the SwiftUI views that display the UI and interact with the ViewModels.

Repositories: Contains the repositories that handle data access and network requests.

UseCases: Contains the use cases that encapsulate the application's business rules.

Services: Contains services like Google Sign-In, Imgur API, and Google Sheets API integration.




