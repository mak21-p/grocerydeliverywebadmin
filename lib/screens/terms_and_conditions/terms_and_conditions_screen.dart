import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  static const String routeName = '/termsandconditions';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => TermsAndConditionsScreen(),
        settings: RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(255, 114, 114, 114),
        ),
        elevation: 0,
        title: const Text(
          'TERMS & CONDITIONS',
          style: TextStyle(
            color: Color.fromARGB(255, 114, 114, 114),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            children: const [
              Text(
                'END USER LICENSE AGREEMENT',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                """1. THE APPLICATION

Yans ('Licensed Application') is a piece of software created to Deliver Groceries and Household Items — and customised for iOS and Android mobile devices ('Devices'). It is used to Order Groceries and Household Items.


2. SCOPE OF LICENCE

2.1  You are given a non-transferable, non-exclusive, non-sublicensable licence to install and use the Licensed Application on any Devices that You (End-User) own or control and as permitted by the Usage Rules, with the exception that such Licensed Application may be accessed and used by other accounts associated with You (End-User, The Purchaser) via Family Sharing or volume purchasing.

2.2  This licence will also govern any updates of the Licensed Application provided by Licensor that replace, repair, and/or supplement the first Licensed Application, unless a separate licence is provided for such update, in which case the terms of that new licence will govern.

2.3  You may not share or make the Licensed Application available to third parties (unless to the degree allowed by the Usage Rules, and with Yans's prior written consent), sell, rent, lend, lease or otherwise redistribute the Licensed Application.

2.4  You may not reverse engineer, translate, disassemble, integrate, decompile, remove, modify, combine, create derivative works or updates of, adapt, or attempt to derive the source code of the Licensed Application, or any part thereof (except with Yans's prior written consent).

2.5  You may not copy (excluding when expressly authorised by this licence and the Usage Rules) or alter the Licensed Application or portions thereof. You may create and store copies only on devices that You own or control for backup keeping under the terms of this licence, the Usage Rules, and any other terms and conditions that apply to the device or software used. You may not remove any intellectual property notices. You acknowledge that no unauthorised third parties may gain access to these copies at any time. If you sell your Devices to a third party, you must remove the Licensed Application from the Devices before doing so.

2.6  Violations of the obligations mentioned above, as well as the attempt of such infringement, may be subject to prosecution and damages.

2.7  Licensor reserves the right to modify the terms and conditions of licensing.

2.8  Nothing in this licence should be interpreted to restrict third-party terms. When using the Licensed Application, You must ensure that You comply with applicable third-party terms and conditions.


3. TECHNICAL REQUIREMENTS

3.1  Licensor attempts to keep the Licensed Application updated so that it complies with modified/new versions of the firmware and new hardware. You are not granted rights to claim such an update.

3.2  You acknowledge that it is Your responsibility to confirm and determine that the app end-user device on which You intend to use the Licensed Application satisfies the technical specifications mentioned above.

3.3  Licensor reserves the right to modify the technical specifications as it sees appropriate at any time.


4. MAINTENANCE AND SUPPORT

4.1  The Licensor is solely responsible for providing any maintenance and support services for this Licensed Application. You can reach the Licensor at the email address listed in the App Store or Play Store Overview for this Licensed Application.

4.2  Yans and the End-User acknowledge that the Services have no obligation whatsoever to furnish any maintenance and support services with respect to the Licensed Application.


5. USER-GENERATED CONTRIBUTIONS

The Licensed Application does not offer users to submit or post content. We may provide you with the opportunity to create, submit, post, display, transmit, perform, publish, distribute, or broadcast content and materials to us or in the Licensed Application, including but not limited to text, writings, video, audio, photographs, graphics, comments, suggestions, or personal information or other material (collectively, 'Contributions'). Contributions may be viewable by other users of the Licensed Application and through third-party websites or applications. As such, any Contributions you transmit may be treated in accordance with the Licensed Application Privacy Policy. When you create or make available any Contributions, you thereby represent and warrant that:

1. The creation, distribution, transmission, public display, or performance, and the accessing, downloading, or copying of your Contributions do not and will not infringe the proprietary rights, including but not limited to the copyright, patent, trademark, trade secret, or moral rights of any third party.
2. You are the creator and owner of or have the necessary licences, rights, consents, releases, and permissions to use and to authorise us, the Licensed Application, and other users of the Licensed Application to use your Contributions in any manner contemplated by the Licensed Application and this Licence Agreement.
3. You have the written consent, release, and/or permission of each and every identifiable individual person in your Contributions to use the name or likeness or each and every such identifiable individual person to enable inclusion and use of your Contributions in any manner contemplated by the Licensed Application and this Licence Agreement.
4. Your Contributions are not false, inaccurate, or misleading.
5. Your Contributions are not unsolicited or unauthorised advertising, promotional materials, pyramid schemes, chain letters, spam, mass mailings, or other forms of solicitation.
6. Your Contributions are not obscene, lewd, lascivious, filthy, violent, harassing, libellous, slanderous, or otherwise objectionable (as determined by us).
7. Your Contributions do not ridicule, mock, disparage, intimidate, or abuse anyone.
8. Your Contributions are not used to harass or threaten (in the legal sense of those terms) any other person and to promote violence against a specific person or class of people.
9. Your Contributions do not violate any applicable law, regulation, or rule.
10. Your Contributions do not violate the privacy or publicity rights of any third party.
11. Your Contributions do not violate any applicable law concerning child pornography, or otherwise intended to protect the health or well-being of minors.
12. Your Contributions do not include any offensive comments that are connected to race, national origin, gender, sexual preference, or physical handicap.
13. Your Contributions do not otherwise violate, or link to material that violates, any provision of this Licence Agreement, or any applicable law or regulation.

Any use of the Licensed Application in violation of the foregoing violates this Licence Agreement and may result in, among other things, termination or suspension of your rights to use the Licensed Application.


6. CONTRIBUTION LICENCE

You agree that we may access, store, process, and use any information and personal data that you provide following the terms of the Privacy Policy and your choices (including settings).

By submitting suggestions of other feedback regarding the Licensed Application, you agree that we can use and share such feedback for any purpose without compensation to you.

We do not assert any ownership over your Contributions. You retain full ownership of all of your Contributions and any intellectual property rights or other proprietary rights associated with your Contributions. We are not liable for any statements or representations in your Contributions provided by you in any area in the Licensed Application. You are solely responsible for your Contributions to the Licensed Application and you expressly agree to exonerate us from any and all responsibility and to refrain from any legal action against us regarding your Contributions.


7. LIABILITY

7.1  Licensor's responsibility in the case of violation of obligations and tort shall be limited to intent and gross negligence. Only in case of a breach of essential contractual duties (cardinal obligations), Licensor shall also be liable in case of slight negligence. In any case, liability shall be limited to the foreseeable, contractually typical damages. The limitation mentioned above does not apply to injuries to life, limb, or health.

7.2  Licensor takes no accountability or responsibility for any damages caused due to a breach of duties according to Section 2 of this Licence Agreement. To avoid data loss, You are required to make use of backup functions of the Licensed Application to the extent allowed by applicable third-party terms and conditions of use. You are aware that in case of alterations or manipulations of the Licensed Application, You will not have access to the Licensed Application.


8. WARRANTY

8.1  Licensor warrants that the Licensed Application is free of spyware, trojan horses, viruses, or any other malware at the time of Your download. Licensor warrants that the Licensed Application works as described in the user documentation.

8.2  No warranty is provided for the Licensed Application that is not executable on the device, that has been unauthorisedly modified, handled inappropriately or culpably, combined or installed with inappropriate hardware or software, used with inappropriate accessories, regardless if by Yourself or by third parties, or if there are any other reasons outside of Yans's sphere of influence that affect the executability of the Licensed Application.

8.3  You are required to inspect the Licensed Application immediately after installing it and notify Yans about issues discovered without delay by email provided in Product Claims. The defect report will be taken into consideration and further investigated if it has been emailed within a period of one (1) days after discovery.

8.4  If we confirm that the Licensed Application is defective, Yans reserves a choice to remedy the situation either by means of solving the defect or substitute delivery.

8.5  In the event of any failure of the Licensed Application to conform to any applicable warranty, You may notify the Services Store Operator, and Your Licensed Application purchase price will be refunded to You. To the maximum extent permitted by applicable law, the Services Store Operator will have no other warranty obligation whatsoever with respect to the Licensed Application, and any other losses, claims, damages, liabilities, expenses, and costs attributable to any negligence to adhere to any warranty.

8.6  If the user is an entrepreneur, any claim based on faults expires after a statutory period of limitation amounting to twelve (12) months after the Licensed Application was made available to the user. The statutory periods of limitation given by law apply for users who are consumers.
   

9. PRODUCT CLAIMS

Yans and the End-User acknowledge that Yans, and not the Services, is responsible for addressing any claims of the End-User or any third party relating to the Licensed Application or the End-User’s possession and/or use of that Licensed Application, including, but not limited to:

(i) product liability claims;
   
(ii) any claim that the Licensed Application fails to conform to any applicable legal or regulatory requirement; and

(iii) claims arising under consumer protection, privacy, or similar legislation, including in connection with Your Licensed Application’s use of the HealthKit and HomeKit.


10. LEGAL COMPLIANCE

You represent and warrant that You are not located in a country that is subject to a US Government embargo, or that has been designated by the US Government as a 'terrorist supporting' country; and that You are not listed on any US Government list of prohibited or restricted parties.


11. CONTACT INFORMATION

For general inquiries, complaints, questions or claims concerning the Licensed Application, please contact:
       
Abdul Aleem
House No 14-36-72/a, Sangam City Colon, Peeramcheruvu Village, Gandipet Mandal, Ranga Reddy, Ranga Reddy, Telangana, 500086
Hyderabad, Telangana 500086
India
yanshyderabad@gmail.com


12. TERMINATION

The licence is valid until terminated by Yans or by You. Your rights under this licence will terminate automatically and without notice from Yans if You fail to adhere to any term(s) of this licence. Upon Licence termination, You shall stop all use of the Licensed Application, and destroy all copies, full or partial, of the Licensed Application.
      

13. THIRD-PARTY TERMS OF AGREEMENTS AND BENEFICIARY

Yans represents and warrants that Yans will comply with applicable third-party terms of agreement when using Licensed Application.

In Accordance with Section 9 of the 'Instructions for Minimum Terms of Developer's End-User Licence Agreement', both Apple and Google and their subsidiaries shall be third-party beneficiaries of this End User Licence Agreement and — upon Your acceptance of the terms and conditions of this Licence Agreement, both Apple and Google will have the right (and will be deemed to have accepted the right) to enforce this End User Licence Agreement against You as a third-party beneficiary thereof.


14. INTELLECTUAL PROPERTY RIGHTS

Yans and the End-User acknowledge that, in the event of any third-party claim that the Licensed Application or the End-User's possession and use of that Licensed Application infringes on the third party's intellectual property rights, Yans, and not the Services, will be solely responsible for the investigation, defence, settlement, and discharge or any such intellectual property infringement claims.


15. APPLICABLE LAW

This Licence Agreement is governed by the laws of India excluding its conflicts of law rules.


16. MISCELLANEOUS

16.1  If any of the terms of this agreement should be or become invalid, the validity of the remaining provisions shall not be affected. Invalid terms will be replaced by valid ones formulated in a way that will achieve the primary purpose.
               
16.2  Collateral agreements, changes and amendments are only valid if laid down in writing. The preceding clause can only be waived in writing.
This EULA was created using Termly's EULA Generator.""",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'PRIVACY NOTICE',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                """This privacy notice for Yans ('Company', 'we', 'us', or 'our',), describes how and why we might collect, store, use, and/or share ('process') your information when you use our services ('Services'), such as when you:
Download and use our mobile application (Yans), or any other application of ours that links to this privacy notice
Engage with us in other related ways, including any sales, marketing, or events
Questions or concerns? Reading this privacy notice will help you understand your privacy rights and choices. If you do not agree with our policies and practices, please do not use our Services. If you still have any questions or concerns, please contact us at yanshyderabad@gmail.com.


SUMMARY OF KEY POINTS

This summary provides key points from our privacy notice, but you can find out more details about any of these topics by clicking the link following each key point or by using our table of contents below to find the section you are looking for. You can also click here to go directly to our table of contents.

What personal information do we process? When you visit, use, or navigate our Services, we may process personal information depending on how you interact with Yans and the Services, the choices you make, and the products and features you use. Click here to learn more.

Do we process any sensitive personal information? We do not process sensitive personal information.

Do we receive any information from third parties? We do not receive any information from third parties.

How do we process your information? We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent. We process your information only when we have a valid legal reason to do so. Click here to learn more.

In what situations and with which parties do we share personal information? We may share information in specific situations and with specific third parties. Click here to learn more.

How do we keep your information safe? We have organisational and technical processes and procedures in place to protect your personal information. However, no electronic transmission over the internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorised third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Click here to learn more.

What are your rights? Depending on where you are located geographically, the applicable privacy law may mean you have certain rights regarding your personal information. Click here to learn more.

How do you exercise your rights? The easiest way to exercise your rights is by filling out our data subject request form available here: yanshyderabad@gmail.com, or by contacting us. We will consider and act upon any request in accordance with applicable data protection laws.

Want to learn more about what Yans does with any information we collect? Click here to review the notice in full.


TABLE OF CONTENTS

1. WHAT INFORMATION DO WE COLLECT?
2. HOW DO WE PROCESS YOUR INFORMATION?
3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?
4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?
5. HOW LONG DO WE KEEP YOUR INFORMATION?
6. HOW DO WE KEEP YOUR INFORMATION SAFE?
7. DO WE COLLECT INFORMATION FROM MINORS?
8. WHAT ARE YOUR PRIVACY RIGHTS?
9. CONTROLS FOR DO-NOT-TRACK FEATURES
10. DO CALIFORNIA RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?
11. DO WE MAKE UPDATES TO THIS NOTICE?
12. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?
13. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?

1. WHAT INFORMATION DO WE COLLECT?

Personal information you disclose to us

In Short: We collect personal information that you provide to us.

We collect personal information that you voluntarily provide to us when you register on the Services, express an interest in obtaining information about us or our products and Services, when you participate in activities on the Services, or otherwise when you contact us.

Personal Information Provided by You. The personal information that we collect depends on the context of your interactions with us and the Services, the choices you make, and the products and features you use. The personal information we collect may include the following:
names
phone numbers
email addresses
mailing addresses
usernames
passwords
billing addresses
debit/credit card numbers
contact or authentication data
Sensitive Information. We do not process sensitive information.

Payment Data. We may collect data necessary to process your payment if you make purchases, such as your payment instrument number (such as a credit card number), and the security code associated with your payment instrument. All payment data is stored by Razorpay. You may find their privacy notice link(s) here: https://razorpay.com/privacy/.

Application Data. If you use our application(s), we also may collect the following information if you choose to provide us with access or permission:
Geolocation Information. We may request access or permission to track location-based information from your mobile device, either continuously or while you are using our mobile application(s), to provide certain location-based services. If you wish to change our access or permissions, you may do so in your device's settings.
Mobile Device Access. We may request access or permission to certain features from your mobile device, including your mobile device's sms messages, and other features. If you wish to change our access or permissions, you may do so in your device's settings.
Push Notifications. We may request to send you push notifications regarding your account or certain features of the application(s). If you wish to opt out from receiving these types of communications, you may turn them off in your device's settings.
This information is primarily needed to maintain the security and operation of our application(s), for troubleshooting, and for our internal analytics and reporting purposes.

All personal information that you provide to us must be true, complete, and accurate, and you must notify us of any changes to such personal information.

Information automatically collected

In Short: Some information — such as your Internet Protocol (IP) address and/or browser and device characteristics — is collected automatically when you visit our Services.

We automatically collect certain information when you visit, use, or navigate the Services. This information does not reveal your specific identity (like your name or contact information) but may include device and usage information, such as your IP address, browser and device characteristics, operating system, language preferences, referring URLs, device name, country, location, information about how and when you use our Services, and other technical information. This information is primarily needed to maintain the security and operation of our Services, and for our internal analytics and reporting purposes.

Like many businesses, we also collect information through cookies and similar technologies.

The information we collect includes:
Log and Usage Data. Log and usage data is service-related, diagnostic, usage, and performance information our servers automatically collect when you access or use our Services and which we record in log files. Depending on how you interact with us, this log data may include your IP address, device information, browser type, and settings and information about your activity in the Services (such as the date/time stamps associated with your usage, pages and files viewed, searches, and other actions you take such as which features you use), device event information (such as system activity, error reports (sometimes called 'crash dumps'), and hardware settings).
Device Data. We collect device data such as information about your computer, phone, tablet, or other device you use to access the Services. Depending on the device used, this device data may include information such as your IP address (or proxy server), device and application identification numbers, location, browser type, hardware model, Internet service provider and/or mobile carrier, operating system, and system configuration information.
Location Data. We collect location data such as information about your device's location, which can be either precise or imprecise. How much information we collect depends on the type and settings of the device you use to access the Services. For example, we may use GPS and other technologies to collect geolocation data that tells us your current location (based on your IP address). You can opt out of allowing us to collect this information either by refusing access to the information or by disabling your Location setting on your device. However, if you choose to opt out, you may not be able to use certain aspects of the Services.
2. HOW DO WE PROCESS YOUR INFORMATION?

In Short: We process your information to provide, improve, and administer our Services, communicate with you, for security and fraud prevention, and to comply with law. We may also process your information for other purposes with your consent.

We process your personal information for a variety of reasons, depending on how you interact with our Services, including:
To facilitate account creation and authentication and otherwise manage user accounts. We may process your information so you can create and log in to your account, as well as keep your account in working order.
To deliver and facilitate delivery of services to the user. We may process your information to provide you with the requested service.
To respond to user inquiries/offer support to users. We may process your information to respond to your inquiries and solve any potential issues you might have with the requested service.
To fulfil and manage your orders. We may process your information to fulfil and manage your orders, payments, returns, and exchanges made through the Services.





3. WHEN AND WITH WHOM DO WE SHARE YOUR PERSONAL INFORMATION?

In Short: We may share information in specific situations described in this section and/or with the following third parties.

We may need to share your personal information in the following situations:
Business Transfers. We may share or transfer your information in connection with, or during negotiations of, any merger, sale of company assets, financing, or acquisition of all or a portion of our business to another company.
When we use Google Maps Platform APIs. We may share your information with certain Google Maps Platform APIs (e.g. Google Maps API, Places API). To find out more about Google’s Privacy Policy, please refer to this link. We use certain Google Maps Platform APIs to retrieve certain information when you make location-specific requests. This includes: Geolocation; and other similar information. A full list of what we use information for can be found in this section and in the previous section titled 'HOW DO WE PROCESS YOUR INFORMATION?'. We obtain and store on your device ('cache') your location. You may revoke your consent anytime by contacting us at the contact details provided at the end of this document. The Google Maps Platform APIs that we use store and access cookies and other information on your devices. If you are a user currently in the European Economic Area (EU countries, Iceland, Liechtenstein, and Norway) or the United Kingdom, please take a look at our Cookie Notice.
Affiliates. We may share your information with our affiliates, in which case we will require those affiliates to honour this privacy notice. Affiliates include our parent company and any subsidiaries, joint venture partners, or other companies that we control or that are under common control with us.
Business Partners. We may share your information with our business partners to offer you certain products, services, or promotions.

4. DO WE USE COOKIES AND OTHER TRACKING TECHNOLOGIES?

In Short: We may use cookies and other tracking technologies to collect and store your information.

We may use cookies and similar tracking technologies (like web beacons and pixels) to access or store information. Specific information about how we use such technologies and how you can refuse certain cookies is set out in our Cookie Notice.

5. HOW LONG DO WE KEEP YOUR INFORMATION?

In Short: We keep your information for as long as necessary to fulfil the purposes outlined in this privacy notice unless otherwise required by law.

We will only keep your personal information for as long as it is necessary for the purposes set out in this privacy notice, unless a longer retention period is required or permitted by law (such as tax, accounting, or other legal requirements). No purpose in this notice will require us keeping your personal information for longer than nine (9) months past the termination of the user's account.

When we have no ongoing legitimate business need to process your personal information, we will either delete or anonymise such information, or, if this is not possible (for example, because your personal information has been stored in backup archives), then we will securely store your personal information and isolate it from any further processing until deletion is possible.

6. HOW DO WE KEEP YOUR INFORMATION SAFE?

In Short: We aim to protect your personal information through a system of organisational and technical security measures.

We have implemented appropriate and reasonable technical and organisational security measures designed to protect the security of any personal information we process. However, despite our safeguards and efforts to secure your information, no electronic transmission over the Internet or information storage technology can be guaranteed to be 100% secure, so we cannot promise or guarantee that hackers, cybercriminals, or other unauthorised third parties will not be able to defeat our security and improperly collect, access, steal, or modify your information. Although we will do our best to protect your personal information, transmission of personal information to and from our Services is at your own risk. You should only access the Services within a secure environment.

7. DO WE COLLECT INFORMATION FROM MINORS?

In Short: We do not knowingly collect data from or market to children under 18 years of age.

We do not knowingly solicit data from or market to children under 18 years of age. By using the Services, you represent that you are at least 18 or that you are the parent or guardian of such a minor and consent to such minor dependent’s use of the Services. If we learn that personal information from users less than 18 years of age has been collected, we will deactivate the account and take reasonable measures to promptly delete such data from our records. If you become aware of any data we may have collected from children under age 18, please contact us at yanshyderabad@gmail.com.

8. WHAT ARE YOUR PRIVACY RIGHTS?

In Short:  You may review, change, or terminate your account at any time.
 
If you are located in the EEA or UK and you believe we are unlawfully processing your personal information, you also have the right to complain to your local data protection supervisory authority. You can find their contact details here: https://ec.europa.eu/justice/data-protection/bodies/authorities/index_en.htm.

If you are located in Switzerland, the contact details for the data protection authorities are available here: https://www.edoeb.admin.ch/edoeb/en/home.html.

Withdrawing your consent: If we are relying on your consent to process your personal information, which may be express and/or implied consent depending on the applicable law, you have the right to withdraw your consent at any time. You can withdraw your consent at any time by contacting us by using the contact details provided in the section 'HOW CAN YOU CONTACT US ABOUT THIS NOTICE?' below.

However, please note that this will not affect the lawfulness of the processing before its withdrawal nor, when applicable law allows, will it affect the processing of your personal information conducted in reliance on lawful processing grounds other than consent.

Account Information

If you would at any time like to review or change the information in your account or terminate your account, you can:
Contact us using the contact information provided.
Upon your request to terminate your account, we will deactivate or delete your account and information from our active databases. However, we may retain some information in our files to prevent fraud, troubleshoot problems, assist with any investigations, enforce our legal terms and/or comply with applicable legal requirements.

If you have questions or comments about your privacy rights, you may email us at yanshyderabad@gmail.com.

9. CONTROLS FOR DO-NOT-TRACK FEATURES

Most web browsers and some mobile operating systems and mobile applications include a Do-Not-Track ('DNT') feature or setting you can activate to signal your privacy preference not to have data about your online browsing activities monitored and collected. At this stage no uniform technology standard for recognising and implementing DNT signals has been finalised. As such, we do not currently respond to DNT browser signals or any other mechanism that automatically communicates your choice not to be tracked online. If a standard for online tracking is adopted that we must follow in the future, we will inform you about that practice in a revised version of this privacy notice.

10. DO CALIFORNIA RESIDENTS HAVE SPECIFIC PRIVACY RIGHTS?

In Short: Yes, if you are a resident of California, you are granted specific rights regarding access to your personal information.

California Civil Code Section 1798.83, also known as the 'Shine The Light' law, permits our users who are California residents to request and obtain from us, once a year and free of charge, information about categories of personal information (if any) we disclosed to third parties for direct marketing purposes and the names and addresses of all third parties with which we shared personal information in the immediately preceding calendar year. If you are a California resident and would like to make such a request, please submit your request in writing to us using the contact information provided below.

If you are under 18 years of age, reside in California, and have a registered account with Services, you have the right to request removal of unwanted data that you publicly post on the Services. To request removal of such data, please contact us using the contact information provided below and include the email address associated with your account and a statement that you reside in California. We will make sure the data is not publicly displayed on the Services, but please be aware that the data may not be completely or comprehensively removed from all our systems (e.g. backups, etc.).

11. DO WE MAKE UPDATES TO THIS NOTICE?

In Short: Yes, we will update this notice as necessary to stay compliant with relevant laws.

We may update this privacy notice from time to time. The updated version will be indicated by an updated 'Revised' date and the updated version will be effective as soon as it is accessible. If we make material changes to this privacy notice, we may notify you either by prominently posting a notice of such changes or by directly sending you a notification. We encourage you to review this privacy notice frequently to be informed of how we are protecting your information.

12. HOW CAN YOU CONTACT US ABOUT THIS NOTICE?

If you have questions or comments about this notice, you may email us at yanshyderabad@gmail.com or by post to:

Yans
House No 14-36-72/a, Sangam City Colon, Peeramcheruvu Village, Gandipet Mandal, Ranga Reddy, Ranga Reddy, Telangana, 500086
Hyderabad, Telangana 500086
India

13. HOW CAN YOU REVIEW, UPDATE, OR DELETE THE DATA WE COLLECT FROM YOU?

Based on the applicable laws of your country, you may have the right to request access to the personal information we collect from you, change that information, or delete it. To request to review, update, or delete your personal information, please visit: yanshyderabad@gmail.com.
This privacy policy was created using Termly's Privacy Policy Generator.""",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Terms and Conditions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                """Welcome to Yans!

These terms and conditions outline the rules and regulations for the use of Yans.

By using this app we assume you accept these terms and conditions. Do not continue to use Yans if you do not agree to take all of the terms and conditions stated on this page.

The following terminology applies to these Terms and Conditions, Privacy Statement and Disclaimer Notice and all Agreements: "Client", "You" and "Your" refers to you, the person log on this website and compliant to the Company’s terms and conditions. "The Company", "Ourselves", "We", "Our" and "Us", refers to our Company. "Party", "Parties", or "Us", refers to both the Client and ourselves. All terms refer to the offer, acceptance and consideration of payment necessary to undertake the process of our assistance to the Client in the most appropriate manner for the express purpose of meeting the Client’s needs in respect of provision of the Company’s stated services, in accordance with and subject to, prevailing law of Netherlands. Any use of the above terminology or other words in the singular, plural, capitalization and/or he/she or they, are taken as interchangeable and therefore as referring to same. Our Terms and Conditions were created with the help of the App Terms and Conditions Generator from App-Privacy-Policy.com

License
Unless otherwise stated, Yans and/or its licensors own the intellectual property rights for all material on Yans. All intellectual property rights are reserved. You may access this from Yans for your own personal use subjected to restrictions set in these terms and conditions.

You must not:

Republish material from Yans
Sell, rent or sub-license material from Yans
Reproduce, duplicate or copy material from Yans
Redistribute content from Yans
This Agreement shall begin on the date hereof.

Parts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the website. Yans does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of Yans, its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, Yans shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this website.

Yans reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

You warrant and represent that:

You are entitled to post the Comments on our App and have all necessary licenses and consents to do so;
The Comments do not invade any intellectual property right, including without limitation copyright, patent or trademark of any third party;
The Comments do not contain any defamatory, libelous, offensive, indecent or otherwise unlawful material which is an invasion of privacy
The Comments will not be used to solicit or promote business or custom or present commercial activities or unlawful activity.
You hereby grant Yans a non-exclusive license to use, reproduce, edit and authorize others to use, reproduce and edit any of your Comments in any and all forms, formats or media.

Hyperlinking to our App
The following organizations may link to our App without prior written approval:

Government agencies;
Search engines;
News organizations;
Online directory distributors may link to our App in the same manner as they hyperlink to the Websites of other listed businesses; and
System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.
These organizations may link to our home page, to publications or to other App information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party’s site.

We may consider and approve other link requests from the following types of organizations:

commonly-known consumer and/or business information sources;
dot.com community sites;
associations or other groups representing charities;
online directory distributors;
internet portals;
accounting, law and consulting firms; and
educational institutions and trade associations.
We will approve link requests from these organizations if we decide that: (a) the link would not make us look unfavorably to ourselves or to our accredited businesses; (b) the organization does not have any negative records with us; (c) the benefit to us from the visibility of the hyperlink compensates the absence of Yans; and (d) the link is in the context of general resource information.

These organizations may link to our App so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products or services; and (c) fits within the context of the linking party’s site.

If you are one of the organizations listed in paragraph 2 above and are interested in linking to our App, you must inform us by sending an e-mail to Yans. Please include your name, your organization name, contact information as well as the URL of your site, a list of any URLs from which you intend to link to our App, and a list of the URLs on our site to which you would like to link. Wait 2-3 weeks for a response.

Approved organizations may hyperlink to our App as follows:

By use of our corporate name; or
By use of the uniform resource locator being linked to; or
By use of any other description of our App being linked to that makes sense within the context and format of content on the linking party’s site.
No use of Yans's logo or other artwork will be allowed for linking absent a trademark license agreement.

iFrames
Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our App.

Content Liability
We shall not be hold responsible for any content that appears on your App. You agree to protect and defend us against all claims that is rising on our App. No link(s) should appear on any Website that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.

Your Privacy
Please read Privacy Policy.

Reservation of Rights
We reserve the right to request that you remove all links or any particular link to our App. You approve to immediately remove all links to our App upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our App, you agree to be bound to and follow these linking terms and conditions.

Removal of links from our App
If you find any link on our App that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.

We do not ensure that the information on this website is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the website remains available or that the material on the website is kept up to date.

Disclaimer
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our App and the use of this website. Nothing in this disclaimer will:

limit or exclude our or your liability for death or personal injury;
limit or exclude our or your liability for fraud or fraudulent misrepresentation;
limit any of our or your liabilities in any way that is not permitted under applicable law; or
exclude any of our or your liabilities that may not be excluded under applicable law.
The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.

As long as the website and the information and services on the website are provided free of charge, we will not be liable for any loss or damage of any nature.""",
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Shipping & Returns Policy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                """Returns
Our policy does not offer refunds. If you have purchased an item from Yans, unfortunately we can’t offer you a refund or exchange.
 
We do not offer returns on our goods. Please double check your order details before finalising your order.
 
Please do not send your purchase back to the manufacturer.
 
Change of Address
If you have entered the wrong address at checkout, you have 2 hours to contact us with your order details (your order, entered address, email address and mobile number) for correction before the order is handed to our delivery service provider Shiprocket. If you fail to reach us within 2 hours of making the order, you are not eligible for further corrections, refunds or cancellation.
 
 
Shipping
Depending on where you live, the time it may take for your exchanged product to reach you, may vary.  
 
Subject to stock availability. 
We try to maintain accurate stock counts on our website but from time to time, there may be a stock discrepancy and we will not be able to fulfill all your items at the time of purchase. In this instance, we will fulfill the available products to you, and contact you about whether you would prefer to await restocking of the back-ordered item or if you would prefer for us to process a refund.
 
Shipping Costs
Shipping costs are calculated during checkout based on weight, dimensions, and destination of the items in the order. Yans does not charge payment for shipping. Shipping Costs are none on all orders.
 
 
Customer service
For all customer service inquiries, please email us at yanshyderabad@gmail.com



""",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
