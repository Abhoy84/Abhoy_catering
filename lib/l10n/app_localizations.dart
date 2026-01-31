import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Abhay Catering'**
  String get appTitle;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contact;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Abhay Catering'**
  String get welcomeMessage;

  /// No description provided for @subTitle.
  ///
  /// In en, this message translates to:
  /// **'Delicious food for every occasion'**
  String get subTitle;

  /// No description provided for @bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get bookNow;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @bestInWestBengal.
  ///
  /// In en, this message translates to:
  /// **'BEST IN WEST BENGAL'**
  String get bestInWestBengal;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Exquisite Catering in\nDigha – '**
  String get heroTitle;

  /// No description provided for @heroTitleHighlight.
  ///
  /// In en, this message translates to:
  /// **'From Sea to\nPlate'**
  String get heroTitleHighlight;

  /// No description provided for @heroDescription.
  ///
  /// In en, this message translates to:
  /// **'Celebrate your special moments with the authentic soul of Bengal. We bring you the freshest catches from the Digha coast and traditional recipes passed down through generations.'**
  String get heroDescription;

  /// No description provided for @startBooking.
  ///
  /// In en, this message translates to:
  /// **'Start Booking'**
  String get startBooking;

  /// No description provided for @viewMenu.
  ///
  /// In en, this message translates to:
  /// **'View Menu'**
  String get viewMenu;

  /// No description provided for @eventsCatered.
  ///
  /// In en, this message translates to:
  /// **'Events Catered'**
  String get eventsCatered;

  /// No description provided for @customerRating.
  ///
  /// In en, this message translates to:
  /// **'Customer Rating'**
  String get customerRating;

  /// No description provided for @freshToday.
  ///
  /// In en, this message translates to:
  /// **'Fresh Today'**
  String get freshToday;

  /// No description provided for @freshTodaySub.
  ///
  /// In en, this message translates to:
  /// **'Daily catch from Digha Mohona'**
  String get freshTodaySub;

  /// No description provided for @tasteTheHeritage.
  ///
  /// In en, this message translates to:
  /// **'TASTE THE HERITAGE'**
  String get tasteTheHeritage;

  /// No description provided for @culinarySpecialties.
  ///
  /// In en, this message translates to:
  /// **'Our Culinary Specialties'**
  String get culinarySpecialties;

  /// No description provided for @exploreFullMenu.
  ///
  /// In en, this message translates to:
  /// **'Explore Full Menu'**
  String get exploreFullMenu;

  /// No description provided for @specialty1Title.
  ///
  /// In en, this message translates to:
  /// **'Coastal Delights'**
  String get specialty1Title;

  /// No description provided for @specialty1Desc.
  ///
  /// In en, this message translates to:
  /// **'Fresh Pomfret, Prawns, and Bhetki sourced daily.'**
  String get specialty1Desc;

  /// No description provided for @specialty2Title.
  ///
  /// In en, this message translates to:
  /// **'Royal Thalis'**
  String get specialty2Title;

  /// No description provided for @specialty2Desc.
  ///
  /// In en, this message translates to:
  /// **'Authentic veg and non-veg traditional spreads.'**
  String get specialty2Desc;

  /// No description provided for @specialty3Title.
  ///
  /// In en, this message translates to:
  /// **'Weddings & Events'**
  String get specialty3Title;

  /// No description provided for @specialty3Desc.
  ///
  /// In en, this message translates to:
  /// **'Full-scale catering for grand celebrations.'**
  String get specialty3Desc;

  /// No description provided for @whyChooseUsTitle.
  ///
  /// In en, this message translates to:
  /// **'Why Choose Abhay Catering?'**
  String get whyChooseUsTitle;

  /// No description provided for @whyChooseUsDesc.
  ///
  /// In en, this message translates to:
  /// **'We combine years of culinary expertise with a deep love for Digha\'s local flavors.'**
  String get whyChooseUsDesc;

  /// No description provided for @feature1Title.
  ///
  /// In en, this message translates to:
  /// **'Local Sourcing'**
  String get feature1Title;

  /// No description provided for @feature1Desc.
  ///
  /// In en, this message translates to:
  /// **'Seafood sourced daily from Digha Mohana.'**
  String get feature1Desc;

  /// No description provided for @feature2Title.
  ///
  /// In en, this message translates to:
  /// **'Hygienic Prep'**
  String get feature2Title;

  /// No description provided for @feature2Desc.
  ///
  /// In en, this message translates to:
  /// **'Strict adherence to safety standards.'**
  String get feature2Desc;

  /// No description provided for @feature3Title.
  ///
  /// In en, this message translates to:
  /// **'Tailored Menus'**
  String get feature3Title;

  /// No description provided for @feature3Desc.
  ///
  /// In en, this message translates to:
  /// **'Customize every dish to suit your taste.'**
  String get feature3Desc;

  /// No description provided for @feature4Title.
  ///
  /// In en, this message translates to:
  /// **'Expert Team'**
  String get feature4Title;

  /// No description provided for @feature4Desc.
  ///
  /// In en, this message translates to:
  /// **'Experienced chefs and attentive servers.'**
  String get feature4Desc;

  /// No description provided for @readyToPlan.
  ///
  /// In en, this message translates to:
  /// **'Ready to Plan Your Event?'**
  String get readyToPlan;

  /// No description provided for @readyToPlanDesc.
  ///
  /// In en, this message translates to:
  /// **'Let us make your next occasion unforgettable with our exquisite catering.'**
  String get readyToPlanDesc;

  /// No description provided for @getQuote.
  ///
  /// In en, this message translates to:
  /// **'Get a Quote'**
  String get getQuote;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'New Digha, West Bengal, India'**
  String get address;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'+91 98765 43210'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'info@abhaycatering.com'**
  String get email;

  /// No description provided for @quickLinks.
  ///
  /// In en, this message translates to:
  /// **'Quick Links'**
  String get quickLinks;

  /// No description provided for @followUs.
  ///
  /// In en, this message translates to:
  /// **'Follow Us'**
  String get followUs;

  /// No description provided for @rightsReserved.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get rightsReserved;

  /// No description provided for @footerDesc.
  ///
  /// In en, this message translates to:
  /// **'Bringing the finest flavors of Digha and Bengal to your table since 2014. Quality, hygiene, and tradition are our hallmarks.'**
  String get footerDesc;

  /// No description provided for @visitUs.
  ///
  /// In en, this message translates to:
  /// **'Visit Us'**
  String get visitUs;

  /// No description provided for @specialMenu.
  ///
  /// In en, this message translates to:
  /// **'Special Menu'**
  String get specialMenu;

  /// No description provided for @weddingPackages.
  ///
  /// In en, this message translates to:
  /// **'Wedding Packages'**
  String get weddingPackages;

  /// No description provided for @eventGallery.
  ///
  /// In en, this message translates to:
  /// **'Event Gallery'**
  String get eventGallery;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @weddingCatering.
  ///
  /// In en, this message translates to:
  /// **'Wedding Catering'**
  String get weddingCatering;

  /// No description provided for @corporateEvents.
  ///
  /// In en, this message translates to:
  /// **'Corporate Events'**
  String get corporateEvents;

  /// No description provided for @homeParties.
  ///
  /// In en, this message translates to:
  /// **'Home Parties'**
  String get homeParties;

  /// No description provided for @beachParties.
  ///
  /// In en, this message translates to:
  /// **'Beach Parties'**
  String get beachParties;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'TERMS OF SERVICE'**
  String get termsOfService;

  /// No description provided for @cookies.
  ///
  /// In en, this message translates to:
  /// **'COOKIES'**
  String get cookies;

  /// No description provided for @bookingFunnel.
  ///
  /// In en, this message translates to:
  /// **'BOOKING FUNNEL'**
  String get bookingFunnel;

  /// No description provided for @step1EventType.
  ///
  /// In en, this message translates to:
  /// **'Step 1: Event Type'**
  String get step1EventType;

  /// No description provided for @planYourOccasion.
  ///
  /// In en, this message translates to:
  /// **'Plan Your Special Occasion'**
  String get planYourOccasion;

  /// No description provided for @selectEventType.
  ///
  /// In en, this message translates to:
  /// **'Please select the type of event you are hosting in Digha.'**
  String get selectEventType;

  /// No description provided for @marriage.
  ///
  /// In en, this message translates to:
  /// **'Marriage'**
  String get marriage;

  /// No description provided for @marriageBengali.
  ///
  /// In en, this message translates to:
  /// **'(বিবাহ / शादी)'**
  String get marriageBengali;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @birthdayBengali.
  ///
  /// In en, this message translates to:
  /// **'(জন্মদিন / जन्मदिन)'**
  String get birthdayBengali;

  /// No description provided for @ringCeremony.
  ///
  /// In en, this message translates to:
  /// **'Ring Ceremony'**
  String get ringCeremony;

  /// No description provided for @ringCeremonyBengali.
  ///
  /// In en, this message translates to:
  /// **'(আংটি অনুষ্ঠান / रिंग)'**
  String get ringCeremonyBengali;

  /// No description provided for @otherEvent.
  ///
  /// In en, this message translates to:
  /// **'Other Event'**
  String get otherEvent;

  /// No description provided for @otherEventBengali.
  ///
  /// In en, this message translates to:
  /// **'(অন্যান্য / अन्य)'**
  String get otherEventBengali;

  /// No description provided for @cantFindEvent.
  ///
  /// In en, this message translates to:
  /// **'Can\'t find your event? Type it here:'**
  String get cantFindEvent;

  /// No description provided for @customEventHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Corporate Meet, Anniversary'**
  String get customEventHint;

  /// No description provided for @nextStep.
  ///
  /// In en, this message translates to:
  /// **'Next Step'**
  String get nextStep;

  /// No description provided for @pleaseSelectEvent.
  ///
  /// In en, this message translates to:
  /// **'Please select an event to continue'**
  String get pleaseSelectEvent;

  /// No description provided for @copyright.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Digha Catering Services. All Rights Reserved.'**
  String get copyright;

  /// No description provided for @selectYourMenu.
  ///
  /// In en, this message translates to:
  /// **'Select Your Menu'**
  String get selectYourMenu;

  /// No description provided for @step2MenuDesc.
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 5: Choose starters, mains and desserts'**
  String get step2MenuDesc;

  /// No description provided for @yourPlate.
  ///
  /// In en, this message translates to:
  /// **'Your Plate'**
  String get yourPlate;

  /// No description provided for @nextLogistics.
  ///
  /// In en, this message translates to:
  /// **'Next: Logistics'**
  String get nextLogistics;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @menuFooter.
  ///
  /// In en, this message translates to:
  /// **'© 2024 Digha Catering Services. Serving traditional Bengali flavors with modern elegance.'**
  String get menuFooter;

  /// No description provided for @step3Logistics.
  ///
  /// In en, this message translates to:
  /// **'Step 3 of 5: Logistics'**
  String get step3Logistics;

  /// No description provided for @nextMenuCustomization.
  ///
  /// In en, this message translates to:
  /// **'Next: Menu Customization'**
  String get nextMenuCustomization;

  /// No description provided for @eventLogistics.
  ///
  /// In en, this message translates to:
  /// **'Event Logistics'**
  String get eventLogistics;

  /// No description provided for @logisticsDesc.
  ///
  /// In en, this message translates to:
  /// **'Tell us when and where the feast begins. We handle the rest.'**
  String get logisticsDesc;

  /// No description provided for @expectedGuestCount.
  ///
  /// In en, this message translates to:
  /// **'Expected Guest Count'**
  String get expectedGuestCount;

  /// No description provided for @minimumGuests.
  ///
  /// In en, this message translates to:
  /// **'Minimum 20 guests for standard catering'**
  String get minimumGuests;

  /// No description provided for @eventDate.
  ///
  /// In en, this message translates to:
  /// **'Event Date'**
  String get eventDate;

  /// No description provided for @serviceTime.
  ///
  /// In en, this message translates to:
  /// **'Service Time'**
  String get serviceTime;

  /// No description provided for @venueAddress.
  ///
  /// In en, this message translates to:
  /// **'Venue Address in Digha'**
  String get venueAddress;

  /// No description provided for @venueHint.
  ///
  /// In en, this message translates to:
  /// **'Enter specific location (e.g., Near New Digha Sea Beach, Hotel Seashore Complex, or private residence in Old Digha)'**
  String get venueHint;

  /// No description provided for @serviceArea.
  ///
  /// In en, this message translates to:
  /// **'We serve all areas across Digha, Mandarmani, and Shankarpur.'**
  String get serviceArea;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @continueToMenu.
  ///
  /// In en, this message translates to:
  /// **'Continue to Menu'**
  String get continueToMenu;

  /// No description provided for @freshIngredients.
  ///
  /// In en, this message translates to:
  /// **'Fresh Local Ingredients'**
  String get freshIngredients;

  /// No description provided for @seafoodSpecialists.
  ///
  /// In en, this message translates to:
  /// **'Sea Food Specialists'**
  String get seafoodSpecialists;

  /// No description provided for @licensedCaterers.
  ///
  /// In en, this message translates to:
  /// **'Licensed Caterers'**
  String get licensedCaterers;

  /// No description provided for @localSupport.
  ///
  /// In en, this message translates to:
  /// **'24/7 Local Support'**
  String get localSupport;

  /// No description provided for @step4Review.
  ///
  /// In en, this message translates to:
  /// **'Step 4 of 5'**
  String get step4Review;

  /// No description provided for @reviewExportSummary.
  ///
  /// In en, this message translates to:
  /// **'Review & Export Summary'**
  String get reviewExportSummary;

  /// No description provided for @finalReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Final Review: Let\'s make your event in Digha perfect.'**
  String get finalReviewTitle;

  /// No description provided for @finalReviewDesc.
  ///
  /// In en, this message translates to:
  /// **'Please double-check your event details and menu selections before confirming.'**
  String get finalReviewDesc;

  /// No description provided for @eventQuickLook.
  ///
  /// In en, this message translates to:
  /// **'Event Quick-Look'**
  String get eventQuickLook;

  /// No description provided for @editDetails.
  ///
  /// In en, this message translates to:
  /// **'Edit Details'**
  String get editDetails;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'DATE'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'TIME'**
  String get time;

  /// No description provided for @guests.
  ///
  /// In en, this message translates to:
  /// **'GUESTS'**
  String get guests;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'LOCATION'**
  String get location;

  /// No description provided for @theSelectedMenu.
  ///
  /// In en, this message translates to:
  /// **'The Selected Menu'**
  String get theSelectedMenu;

  /// No description provided for @changeSelection.
  ///
  /// In en, this message translates to:
  /// **'Change Selection'**
  String get changeSelection;

  /// No description provided for @starters.
  ///
  /// In en, this message translates to:
  /// **'Starters'**
  String get starters;

  /// No description provided for @mains.
  ///
  /// In en, this message translates to:
  /// **'Mains'**
  String get mains;

  /// No description provided for @desserts.
  ///
  /// In en, this message translates to:
  /// **'Desserts'**
  String get desserts;

  /// No description provided for @readyToProceed.
  ///
  /// In en, this message translates to:
  /// **'Ready to proceed?'**
  String get readyToProceed;

  /// No description provided for @downloadQuoteDesc.
  ///
  /// In en, this message translates to:
  /// **'Download your quote for reference or confirm to book now.'**
  String get downloadQuoteDesc;

  /// No description provided for @downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get downloadPdf;

  /// No description provided for @confirmSend.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Send via\nWhatsApp/Email'**
  String get confirmSend;

  /// No description provided for @bookingRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Booking Request Sent Successfully!'**
  String get bookingRequestSent;

  /// No description provided for @bookingId.
  ///
  /// In en, this message translates to:
  /// **'Booking ID'**
  String get bookingId;

  /// No description provided for @bookingConfirmationDesc.
  ///
  /// In en, this message translates to:
  /// **'Thank you for choosing us! We have received your request and our local Digha office will contact you within 24 hours to finalize your special menu.'**
  String get bookingConfirmationDesc;

  /// No description provided for @pdfReceipt.
  ///
  /// In en, this message translates to:
  /// **'PDF Receipt'**
  String get pdfReceipt;

  /// No description provided for @whatsappUs.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp Us'**
  String get whatsappUs;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @whatHappensNext.
  ///
  /// In en, this message translates to:
  /// **'What happens next?'**
  String get whatHappensNext;

  /// No description provided for @requestReceived.
  ///
  /// In en, this message translates to:
  /// **'Request Received'**
  String get requestReceived;

  /// No description provided for @requestReceivedDesc.
  ///
  /// In en, this message translates to:
  /// **'Our team is reviewing your requirements'**
  String get requestReceivedDesc;

  /// No description provided for @expertVerificationCall.
  ///
  /// In en, this message translates to:
  /// **'Expert Verification Call'**
  String get expertVerificationCall;

  /// No description provided for @expertVerificationCallDesc.
  ///
  /// In en, this message translates to:
  /// **'Within 24 hours to finalize guest count & dishes'**
  String get expertVerificationCallDesc;

  /// No description provided for @bookingConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmation'**
  String get bookingConfirmation;

  /// No description provided for @bookingConfirmationDescShort.
  ///
  /// In en, this message translates to:
  /// **'Pay the advance to secure your dates'**
  String get bookingConfirmationDescShort;

  /// No description provided for @makeItExtraSpecial.
  ///
  /// In en, this message translates to:
  /// **'Make it Extra Special'**
  String get makeItExtraSpecial;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @addOnServicesDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your celebration with our popular add-on services'**
  String get addOnServicesDesc;

  /// No description provided for @flowerDecoration.
  ///
  /// In en, this message translates to:
  /// **'Flower Decoration'**
  String get flowerDecoration;

  /// No description provided for @flowerDecorationDesc.
  ///
  /// In en, this message translates to:
  /// **'Traditional marigold & rose arrangements for your venue.'**
  String get flowerDecorationDesc;

  /// No description provided for @photographyServices.
  ///
  /// In en, this message translates to:
  /// **'Photography Services'**
  String get photographyServices;

  /// No description provided for @photographyServicesDesc.
  ///
  /// In en, this message translates to:
  /// **'Capture every smile with our award-winning photographers.'**
  String get photographyServicesDesc;

  /// No description provided for @liveMusicBand.
  ///
  /// In en, this message translates to:
  /// **'Live Music/Band'**
  String get liveMusicBand;

  /// No description provided for @liveMusicBandDesc.
  ///
  /// In en, this message translates to:
  /// **'Sufi, Folk, or Bollywood music to set the festive mood.'**
  String get liveMusicBandDesc;

  /// No description provided for @enquireNow.
  ///
  /// In en, this message translates to:
  /// **'Enquire Now'**
  String get enquireNow;

  /// No description provided for @step2ServiceType.
  ///
  /// In en, this message translates to:
  /// **'Step 2: Service Type'**
  String get step2ServiceType;

  /// No description provided for @selectServiceType.
  ///
  /// In en, this message translates to:
  /// **'Select Your Service Type'**
  String get selectServiceType;

  /// No description provided for @serviceTypeDesc.
  ///
  /// In en, this message translates to:
  /// **'Choose the type of service that best fits your celebration'**
  String get serviceTypeDesc;

  /// No description provided for @allContract.
  ///
  /// In en, this message translates to:
  /// **'All Contract'**
  String get allContract;

  /// No description provided for @allContractDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete catering solution with cooking, serving, and cleanup'**
  String get allContractDesc;

  /// No description provided for @allContractBengali.
  ///
  /// In en, this message translates to:
  /// **'(সম্পূর্ণ চুক্তি / पूर्ण अनुबंध)'**
  String get allContractBengali;

  /// No description provided for @cookAndServe.
  ///
  /// In en, this message translates to:
  /// **'Cook & Serve'**
  String get cookAndServe;

  /// No description provided for @cookAndServeDesc.
  ///
  /// In en, this message translates to:
  /// **'Professional cooking and serving staff for your event'**
  String get cookAndServeDesc;

  /// No description provided for @cookAndServeBengali.
  ///
  /// In en, this message translates to:
  /// **'(রান্না ও পরিবেশন / खाना बनाना और परोसना)'**
  String get cookAndServeBengali;

  /// No description provided for @onlyCook.
  ///
  /// In en, this message translates to:
  /// **'Only Cook'**
  String get onlyCook;

  /// No description provided for @onlyCookDesc.
  ///
  /// In en, this message translates to:
  /// **'Expert chefs to prepare delicious meals at your venue'**
  String get onlyCookDesc;

  /// No description provided for @onlyCookBengali.
  ///
  /// In en, this message translates to:
  /// **'(শুধুমাত্র রান্না / केवल खाना बनाना)'**
  String get onlyCookBengali;

  /// No description provided for @onlyServe.
  ///
  /// In en, this message translates to:
  /// **'Only Serve'**
  String get onlyServe;

  /// No description provided for @onlyServeDesc.
  ///
  /// In en, this message translates to:
  /// **'Professional serving staff for your prepared food'**
  String get onlyServeDesc;

  /// No description provided for @onlyServeBengali.
  ///
  /// In en, this message translates to:
  /// **'(শুধুমাত্র পরিবেশন / केवल परोसना)'**
  String get onlyServeBengali;

  /// No description provided for @onlyStarter.
  ///
  /// In en, this message translates to:
  /// **'Only Starter'**
  String get onlyStarter;

  /// No description provided for @onlyStarterDesc.
  ///
  /// In en, this message translates to:
  /// **'Delicious appetizers and starters for your guests'**
  String get onlyStarterDesc;

  /// No description provided for @onlyStarterBengali.
  ///
  /// In en, this message translates to:
  /// **'(শুধুমাত্র স্টার্টার / केवल स्टार्टर)'**
  String get onlyStarterBengali;

  /// No description provided for @mocktail.
  ///
  /// In en, this message translates to:
  /// **'Mocktail Service'**
  String get mocktail;

  /// No description provided for @mocktailDesc.
  ///
  /// In en, this message translates to:
  /// **'Refreshing mocktails and beverages for your celebration'**
  String get mocktailDesc;

  /// No description provided for @mocktailBengali.
  ///
  /// In en, this message translates to:
  /// **'(মকটেল / मॉकटेल)'**
  String get mocktailBengali;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @pleaseSelectService.
  ///
  /// In en, this message translates to:
  /// **'Please select a service type to continue'**
  String get pleaseSelectService;

  /// No description provided for @reviewAndConfirm.
  ///
  /// In en, this message translates to:
  /// **'Review & Confirm'**
  String get reviewAndConfirm;

  /// No description provided for @eventDetails.
  ///
  /// In en, this message translates to:
  /// **'Event Details'**
  String get eventDetails;

  /// No description provided for @venue.
  ///
  /// In en, this message translates to:
  /// **'Venue'**
  String get venue;

  /// No description provided for @selectedMenuItems.
  ///
  /// In en, this message translates to:
  /// **'Selected Menu Items'**
  String get selectedMenuItems;

  /// No description provided for @confirmAndSend.
  ///
  /// In en, this message translates to:
  /// **'Confirm & Send'**
  String get confirmAndSend;

  /// No description provided for @eventType.
  ///
  /// In en, this message translates to:
  /// **'Event Type'**
  String get eventType;

  /// No description provided for @serviceType.
  ///
  /// In en, this message translates to:
  /// **'Service Type'**
  String get serviceType;

  /// No description provided for @guestCount.
  ///
  /// In en, this message translates to:
  /// **'Guest Count'**
  String get guestCount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['bn', 'en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn':
      return AppLocalizationsBn();
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
