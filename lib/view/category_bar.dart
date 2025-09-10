import 'package:flutter/material.dart';

typedef OnCategorySelected = void Function(String category);

class CategoryBar extends StatelessWidget {
  final List<String> categories;
  final String selectedCategory;
  final OnCategorySelected onCategorySelected;

  const CategoryBar({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  // Optional: map categories to icons
  IconData _getIcon(String category) {
    switch (category.toLowerCase()) {
      case 'top news':
        return Icons.article;
      case 'sport':
        return Icons.sports_soccer;
      case 'politics':
        return Icons.how_to_vote;
      case 'world':
        return Icons.public;
      case 'finance':
        return Icons.attach_money;
      case 'health':
        return Icons.health_and_safety;
      case 'technology':
        return Icons.computer;
      default:
        return Icons.newspaper;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 4),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          final isSelected = selectedCategory == item;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blueAccent : Colors.grey[200],
              borderRadius: BorderRadius.circular(22),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: InkWell(
              onTap: () => onCategorySelected(item),
              borderRadius: BorderRadius.circular(16),
              child: Row(
                children: [
                  Icon(
                    _getIcon(item),
                    size: 20,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    item,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
