import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Notes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Bonjour, Franck',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Qu\'allez-vous noter aujourd\'hui ?',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),

            // Quick Actions Grid
            Row(
              children: [
                _buildActionCard(
                  context,
                  icon: Icons.note_add,
                  label: 'Nouvelle Note',
                  color: Colors.blueAccent,
                  onTap: () {},
                ),
                const SizedBox(width: 16),
                _buildActionCard(
                  context,
                  icon: Icons.summarize,
                  label: 'Résumer (IA)',
                  color: Colors.purpleAccent,
                  onTap: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // Recent Notes Header
            Text(
              'Notes Récentes',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 16),
            
            // Placeholder List
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.white10,
                        child: Icon(Icons.article, color: Colors.white70),
                      ),
                      title: Text('Réunion Projet Alpha ${index + 1}'),
                      subtitle: Text(
                        'Discussion sur les nouvelles fonctionnalités et la roadmap...',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: const Text('14:30'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          child: Column(
            children: [
              Icon(icon, size: 32, color: color),
              const SizedBox(height: 12),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
