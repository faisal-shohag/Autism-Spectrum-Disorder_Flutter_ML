import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:remixicon/remixicon.dart';

List<String> pageData = [
  '''
  Our vision is to leverage cutting-edge machine learning technology to develop an innovative application that empowers individuals and caregivers to detect autism spectrum disorder (ASD) with accuracy and efficiency. By harnessing the power of artificial intelligence, our app aims to provide early detection and intervention, leading to improved outcomes and better quality of life for individuals with ASD and their families. We envision a future where our app becomes a valuable tool in the hands of healthcare professionals, educators, and parents, facilitating timely diagnosis, personalized treatment plans, and ongoing support for individuals across all stages of development. Through continuous research, collaboration, and refinement, we strive to make a meaningful impact in the field of autism diagnosis and care, ultimately promoting inclusivity, understanding, and empowerment for individuals with ASD worldwide.
''',
  '''
<ul>
 <li> 
 <b>Data Collection and Purpose:</b> Our application collects image data from various autistic schools and foundations solely for the purpose of training our machine learning model to detect autism spectrum disorder (ASD). When users upload images to test for autism, the image data is saved temporarily for processing and analysis.
 <li>
 <li>
  <b>Data Storage and Security:</b> All collected image data is securely stored in our database with strict access controls to prevent unauthorized access or misuse. We employ industry-standard security measures to safeguard the confidentiality and integrity of the data.
 </li>
  <li>
 <b> Data Usage and Sharing:</b> The collected image data is used exclusively for training and improving our machine learning model to enhance the accuracy of autism detection. We do not share, sell, or distribute the image data to third parties for any other purposes without explicit consent from the users or as required by law.
  </li>

  <li>
    <b>User Consent:</b> Users uploading images for testing are explicitly informed about the data collection and processing practices through our privacy policy and consent forms. By using our application and uploading images, users consent to the collection and processing of their image data for the stated purposes.
  </li>

  <li>
  <b>Data Retention:</b> We retain the collected image data for as long as necessary to fulfill the purposes outlined in this policy and to improve the performance of our machine learning model. Once the data is no longer needed for these purposes, it will be securely deleted from our database.
  </li>

  <li>
  <b>User Rights:</b> Users have the right to request access to their uploaded image data, request corrections or deletions of their data, and withdraw their consent for data processing at any time. We provide mechanisms for users to exercise these rights and ensure compliance with applicable data protection laws.
  </li>

  <li>
  <b>Policy Updates:</b> We may update our data policy from time to time to reflect changes in our data processing practices or regulatory requirements. Users will be notified of any significant changes to the policy, and their continued use of the application will constitute acceptance of the updated policy.
  </li>
 </ul>
  <br>
 <i>By using our application, users acknowledge and agree to abide by the terms of this data policy. If users have any questions or concerns regarding the collection or processing of their data, they can contact us for further assistance.</i><br><br>
''',
  '''
<ol><li><p><strong>Prediction Outcome</strong>: Upon uploading an image for testing, our AI model processes the image data and generates a prediction regarding the likelihood of autism spectrum disorder (ASD) based on the features extracted from the image.</p></li><li><p><strong>Interpretation of Prediction Probability</strong>: The prediction probability generated by our AI model serves as an indicator of the confidence level in the prediction outcome. If the prediction probability is greater than or equal to 70%, the status is classified as "Safe," indicating a high confidence level in the absence of ASD based on the image analysis.</p></li><li><p><strong>Moderate Confidence Level</strong>: If the prediction probability falls between 60% and 70%, the status is categorized as "Moderate." This suggests a moderate level of confidence in the prediction outcome, indicating a possibility of ASD, but with some uncertainty.</p></li><li><p><strong>Severe Confidence Level</strong>: In cases where the prediction probability is below 60%, the status is labeled as "Severe." This indicates a lower confidence level in the prediction outcome, suggesting a higher likelihood of ASD based on the image analysis.</p></li><li><p><strong>User Guidance</strong>: Users are provided with clear guidance and interpretation of the prediction outcome along with the corresponding status classification. This helps users understand the level of confidence in the prediction and enables them to make informed decisions regarding further evaluation or intervention.</p></li><li><p><strong>Next Steps</strong>: Depending on the prediction outcome and status classification, users may be encouraged to seek professional evaluation or support services if necessary, especially in cases classified as "Moderate" or "Severe." Additionally, users may be provided with resources or recommendations for follow-up actions based on the prediction outcome.</p></li><li><p><strong>Continuous Improvement</strong>: We are committed to continuously improving the accuracy and reliability of our AI model through ongoing training and refinement. User feedback and real-world data are essential for enhancing the performance of our model and ensuring the best possible outcomes for individuals undergoing ASD assessment.</p></li></ol>
''',
];

class OurSelf extends StatelessWidget {
  final String title;
  final index;
  const OurSelf({required this.title, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Remix.arrow_left_s_line,
            color: Colors.white,
            size: 30,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          margin: EdgeInsets.only(bottom: 50),
          child: Html(
            data: pageData[index],
            style: {
              "p": Style(
                fontSize: FontSize(16),
              ),
              "ul": Style(
                fontSize: FontSize(16),
              ),
            },
          ),
        ),
      ),
    );
  }
}
