import 'package:flutter/material.dart';

class PriceEstimateScreen extends StatefulWidget {
  const PriceEstimateScreen({super.key});

  @override
  State<PriceEstimateScreen> createState() => _PriceEstimateScreenState();
}

class _PriceEstimateScreenState extends State<PriceEstimateScreen> {
  int selectedIssueIndex = 0;
  int selectedUrgencyIndex = 0;
  bool includeMaterials = true;
  final TextEditingController promoController = TextEditingController();
  bool isPromoApplied = false;

  final List<Map<String, dynamic>> issueTypes = [
    {
      'title': 'Pipe Leakage',
      'baseLabor': 50.0,
      'estHours': '1 - 1.5 hrs',
      'materialCost': 20.0,
      'icon': Icons.water_drop_outlined,
    },
    {
      'title': 'Pipe Replacement',
      'baseLabor': 75.0,
      'estHours': '1.5 - 2.5 hrs',
      'materialCost': 35.0,
      'icon': Icons.build_outlined,
    },
    {
      'title': 'Clogged Drain',
      'baseLabor': 40.0,
      'estHours': '1 hr',
      'materialCost': 10.0,
      'icon': Icons.cleaning_services_outlined,
    },
    {
      'title': 'Fixture Installation',
      'baseLabor': 60.0,
      'estHours': '1 - 2 hrs',
      'materialCost': 45.0,
      'icon': Icons.plumbing_outlined,
    },
  ];

  final List<Map<String, dynamic>> urgencyLevels = [
    {
      'label': 'Standard',
      'sub': 'Within 24-48 hrs',
      'extraFee': 0.0,
      'icon': Icons.schedule_outlined,
    },
    {
      'label': 'Urgent',
      'sub': 'Today by 5 PM',
      'extraFee': 15.0,
      'icon': Icons.bolt_outlined,
    },
    {
      'label': 'Emergency',
      'sub': 'Within 45 mins',
      'extraFee': 30.0,
      'icon': Icons.warning_amber_rounded,
    },
  ];

  double get baseDiagnostic => 35.0;
  double get serviceFee => 5.0;
  double get discount => isPromoApplied ? 15.0 : 0.0;

  double get currentLabor =>
      issueTypes[selectedIssueIndex]['baseLabor'] as double;
  double get currentMaterials => includeMaterials
      ? (issueTypes[selectedIssueIndex]['materialCost'] as double)
      : 0.0;
  double get urgencyFee =>
      urgencyLevels[selectedUrgencyIndex]['extraFee'] as double;

  double get subtotal =>
      baseDiagnostic + currentLabor + currentMaterials + urgencyFee + serviceFee;
  double get totalEstimate => subtotal - discount;

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0F172A)),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'Price Estimate',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, color: Color(0xFF64748B)),
            onPressed: () {
              _showInfoDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AI Powered Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEFF6FF), Color(0xFFDBEAFE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0066FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI Smart Estimator',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E3A8A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Calculated using local rates & task scope',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF3B82F6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Service & Technician Card Snippet
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFCBD5E1),
                      image: const DecorationImage(
                        image: NetworkImage(
                          'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=400',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Navam Shrestha',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Plumber & Pipe Specialist',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF0066FF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Rate: \$40 - \$50 / hr',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Select Issue Type
            const Text(
              'Select Problem Type',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(issueTypes.length, (index) {
                final isSelected = selectedIssueIndex == index;
                final item = issueTypes[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedIssueIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFEFF6FF)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF0066FF)
                            : const Color(0xFFE2E8F0),
                        width: isSelected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item['icon'] as IconData,
                          size: 18,
                          color: isSelected
                              ? const Color(0xFF0066FF)
                              : const Color(0xFF64748B),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item['title'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.w500,
                            color: isSelected
                                ? const Color(0xFF0066FF)
                                : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Urgency & Timeline Selection
            const Text(
              'Select Service Urgency',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: List.generate(urgencyLevels.length, (index) {
                final isSelected = selectedUrgencyIndex == index;
                final level = urgencyLevels[index];
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: index < urgencyLevels.length - 1 ? 8.0 : 0.0,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedUrgencyIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFFEFF6FF)
                              : const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF0066FF)
                                : const Color(0xFFE2E8F0),
                            width: isSelected ? 1.5 : 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              level['icon'] as IconData,
                              size: 20,
                              color: isSelected
                                  ? const Color(0xFF0066FF)
                                  : const Color(0xFF64748B),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              level['label'] as String,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: isSelected
                                    ? const Color(0xFF0066FF)
                                    : const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              level['extraFee'] > 0
                                  ? '+\$${(level['extraFee'] as double).toStringAsFixed(0)}'
                                  : 'Standard',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: level['extraFee'] > 0
                                    ? const Color(0xFF059669)
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),

            // Material Option Switch
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Include Parts & Materials',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Estimated cost: \$${(issueTypes[selectedIssueIndex]['materialCost'] as double).toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  Switch.adaptive(
                    value: includeMaterials,
                    activeColor: const Color(0xFF0066FF),
                    onChanged: (val) {
                      setState(() {
                        includeMaterials = val;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Cost Breakdown Card
            const Text(
              'Cost Breakdown',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x05000000),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildCostRow(
                    label: 'Diagnostic & Inspection Fee',
                    value: '\$${baseDiagnostic.toStringAsFixed(2)}',
                  ),
                  const SizedBox(height: 10),
                  _buildCostRow(
                    label:
                        'Labor (${issueTypes[selectedIssueIndex]['estHours']})',
                    value: '\$${currentLabor.toStringAsFixed(2)}',
                  ),
                  if (includeMaterials) ...[
                    const SizedBox(height: 10),
                    _buildCostRow(
                      label: 'Parts & Spare Materials',
                      value: '\$${currentMaterials.toStringAsFixed(2)}',
                    ),
                  ],
                  if (urgencyFee > 0) ...[
                    const SizedBox(height: 10),
                    _buildCostRow(
                      label:
                          'Urgency Charge (${urgencyLevels[selectedUrgencyIndex]['label']})',
                      value: '+\$${urgencyFee.toStringAsFixed(2)}',
                      valueColor: const Color(0xFFD97706),
                    ),
                  ],
                  const SizedBox(height: 10),
                  _buildCostRow(
                    label: 'Service & Safety Fee',
                    value: '\$${serviceFee.toStringAsFixed(2)}',
                  ),
                  if (isPromoApplied) ...[
                    const SizedBox(height: 10),
                    _buildCostRow(
                      label: 'Promo Discount (FIXIOAI)',
                      value: '-\$${discount.toStringAsFixed(2)}',
                      valueColor: const Color(0xFF16A34A),
                    ),
                  ],
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(color: Color(0xFFE2E8F0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Estimated Total',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Final price may vary ±10%',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '\$${totalEstimate.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0066FF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Promo Code Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_offer_outlined,
                    color: Color(0xFF64748B),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: promoController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Promo Code (e.g. FIXIOAI)',
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (promoController.text.trim().isNotEmpty) {
                        setState(() {
                          isPromoApplied = true;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Promo Code FIXIOAI Applied! -\$15.00'),
                            backgroundColor: Color(0xFF16A34A),
                          ),
                        );
                      }
                    },
                    child: Text(
                      isPromoApplied ? 'Applied' : 'Apply',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isPromoApplied
                            ? const Color(0xFF16A34A)
                            : const Color(0xFF0066FF),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Guarantee Box
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFBBF7D0)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(
                    Icons.verified_user_outlined,
                    color: Color(0xFF16A34A),
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Transparent Pricing Guarantee: No surprise charges. The technician will confirm the scope before starting any work.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF15803D),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: Color(0xFFE2E8F0)),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 10,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Estimate',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '\$${totalEstimate.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Proceeding to Schedule & Booking...'),
                      backgroundColor: Color(0xFF0066FF),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Confirm & Schedule',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCostRow({
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF475569),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? const Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About AI Estimates'),
        content: const Text(
          'Fixio uses machine learning to compare historical job costs, technician hourly rates, parts prices, and urgency factors to generate an accurate estimate upfront.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}
