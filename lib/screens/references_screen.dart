import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/theme_provider.dart';

class ReferencesScreen extends StatelessWidget {
  final List<String> references = [
    'Acevedo, A., & Perera, O. P. (2020). House fly (Musca domestica): Biology and management. University of Florida IFAS Extension. EENY-048.',
    'Su, N.-Y. (2019). Termite biology and behavior. In C. Schal & E. L. Vargo (Eds.), Advances in insect physiology (Vol. 56, pp. 1-48). Academic Press.',
    'Miller, D. M., & Koehler, P. G. (2021). Cockroach control manual. University of Florida IFAS Extension. SP486.',
    'CDC. (2023). Mosquitoes and diseases. Centers for Disease Control and Prevention. https://www.cdc.gov/mosquitoes',
    'Doggett, S. L., et al. (2018). Bed bugs: Clinical relevance and control options. Clinical Microbiology Reviews, 31(1), e00045-17.',
    'Hölldobler, B., & Wilson, E. O. (1990). The ants. Harvard University Press.',
    'Rust, M. K. (2017). The biology and ecology of cat fleas and advancements in their pest management. Insects, 8(4), 118.',
    'van Emden, H. F., & Harrington, R. (2017). Aphids as crop pests (2nd ed.). CABI.',
    'Potter, D. A., & Held, D. W. (2002). Biology and management of the Japanese beetle. Annual Review of Entomology, 47, 175-205.',
    'Leskey, T. C., et al. (2012). Pest status of the brown marmorated stink bug in the USA. Outlooks on Pest Management, 23(5), 218-226.',
    'Meerburg, B. G., Singleton, G. R., & Kijlstra, A. (2009). Rodent-borne diseases and their risks to public health. Critical Reviews in Microbiology, 35(3), 221-270. https://doi.org/10.1080/10408410902989837',
    'Feng, A. Y. T., & Himsworth, C. G. (2014). The secret life of the city rat: A review of the ecology of urban Norway and black rats (Rattus norvegicus and Rattus rattus). Urban Ecosystems, 17(1), 149-162. https://doi.org/10.1007/s11252-013-0305-4',
    'EPA. (2022). Mold and health. United States Environmental Protection Agency. https://www.epa.gov/mold/mold-and-health',
    'Glawe, D. A. (2008). The powdery mildews: A review of the world\'s most familiar (yet poorly known) plant pathogens. Annual Review of Phytopathology, 46, 27-51. https://doi.org/10.1146/annurev.phyto.46.081407.104740',
    'Haag-Wackernagel, D., & Moch, H. (2004). Health hazards posed by feral pigeons. Journal of Infection, 48(4), 307-313. https://doi.org/10.1016/j.jinf.2003.11.001',
    'Linz, G. M., et al. (2007). European starlings: A review of an invasive species with far-reaching impacts. Managing Vertebrate Invasive Species, 24, 378-386. USDA National Wildlife Research Center.',
    'Van Leeuwen, T., et al. (2010). The economic importance of acaricides in the control of spider mites. Annual Review of Entomology, 55, 591-612. https://doi.org/10.1146/annurev-ento-112408-085516',
    'Platts-Mills, T. A. E., et al. (1992). Dust mite allergens and asthma: A worldwide problem. Journal of Allergy and Clinical Immunology, 89(5), 1046-1060. https://doi.org/10.1016/0091-6749(92)90282-F',
    'Barker, G. M. (Ed.). (2004). Natural enemies of terrestrial molluscs. CABI. https://doi.org/10.1079/9780851993195.0000',
    'USGS. (2021). Zebra mussel (Dreissena polymorpha) fact sheet. United States Geological Survey. https://nas.er.usgs.gov/queries/FactSheet.aspx?speciesID=5',
    'Jones, J. T., et al. (2013). Top 10 plant-parasitic nematodes in molecular plant pathology. Molecular Plant Pathology, 14(9), 946-961. https://doi.org/10.1111/mpp.12057',
    'UC IPM. (2020). Dandelion management guidelines. University of California Statewide Integrated Pest Management Program. https://ipm.ucanr.edu/PMG/PESTNOTES/pn7469.html',
    'Fry, W. E., & Goodwin, S. B. (1997). Re-emergence of potato and tomato late blight in the United States. Plant Disease, 81(12), 1349-1357. https://doi.org/10.1094/PDIS.1997.81.12.1349',
    'NIH. (2023). Black widow spider toxicity. National Institutes of Health. https://www.ncbi.nlm.nih.gov/books/NBK499987/'
  ];

  // Method to launch URLs if available
  Future<void> _launchUrl(String reference) async {
    // Extract URL from reference if exists
    final urlRegex = RegExp(r'https?://\S+');
    final match = urlRegex.firstMatch(reference);
    
    if (match != null) {
      final String url = match.group(0)!;
      final Uri uri = Uri.parse(url);
      
      try {
        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          throw Exception('Could not launch $url');
        }
      } catch (e) {
        print('Error launching URL: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text('References'),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDarkMode 
              ? [Colors.grey[850]!, Colors.grey[900]!] 
              : [Colors.green[50]!, Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: references.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Text(
                  references[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
                trailing: _hasUrl(references[index]) 
                  ? IconButton(
                      icon: Icon(
                        Icons.open_in_new,
                        color: isDarkMode ? Colors.white : Colors.black54,
                      ),
                      onPressed: () => _launchUrl(references[index]),
                    )
                  : null,
              ),
            );
          },
        ),
      ),
    );
  }

  // Helper method to check if reference contains a URL
  bool _hasUrl(String reference) {
    final urlRegex = RegExp(r'https?://\S+');
    return urlRegex.hasMatch(reference);
  }
}