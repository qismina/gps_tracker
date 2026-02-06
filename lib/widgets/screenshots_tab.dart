import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/theme/app_theme.dart';
import '../providers/saved_screenshots_provider.dart';
import '../providers/providers.dart';

/// Screenshots tab content for Walking History
class ScreenshotsTab extends ConsumerWidget {
  const ScreenshotsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(screenshotsRefreshProvider);
    final screenshotsAsync = ref.watch(savedScreenshotsProvider);

    return screenshotsAsync.when(
      data: (screenshots) {
        if (screenshots.isEmpty) {
          return _buildEmptyState();
        }
        return _buildScreenshotList(context, ref, screenshots);
      },
      loading: () => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryPurple),
        ),
      ),
      error: (error, stack) => _buildErrorState(error.toString()),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.photo_library_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'No screenshots yet',
            style: AppTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textLight,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          const Text(
            'Start walking to save route screenshots',
            style: AppTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: AppTheme.errorRed,
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'Error loading screenshots',
            style: AppTheme.bodyLarge.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXL),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: AppTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScreenshotList(
    BuildContext context,
    WidgetRef ref,
    List<String> screenshots,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: screenshots.length,
      itemBuilder: (context, index) {
        final screenshotPath = screenshots[index];
        return _buildScreenshotCard(context, ref, screenshotPath);
      },
    );
  }

  Widget _buildScreenshotCard(
    BuildContext context,
    WidgetRef ref,
    String screenshotPath,
  ) {
    final file = File(screenshotPath);
    final fileName = screenshotPath.split('/').last;
    final dateTime = _extractDateTime(fileName);

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () => _showFullScreenImage(context, ref, screenshotPath),
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Row(
            children: [
              // Map Thumbnail
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        child: const Icon(
                          Icons.broken_image,
                          size: 32,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(width: AppTheme.spacingM),

              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Text(
                      _formatDate(dateTime),
                      style: AppTheme.sectionHeader.copyWith(fontSize: 18),
                    ),
                    
                    const SizedBox(height: AppTheme.spacingS),

                    // Stats Row
                    const Row(
                      children: [
                        // Time icon and placeholder
                        Icon(
                          Icons.timer_rounded,
                          size: 16,
                          color: AppTheme.textLight,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '--',
                          style: AppTheme.bodySmall,
                        ),

                        SizedBox(width: AppTheme.spacingM),

                        // Distance icon and placeholder
                        Icon(
                          Icons.straighten_rounded,
                          size: 16,
                          color: AppTheme.textLight,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '--',
                          style: AppTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Delete Button
              IconButton(
                icon: const Icon(Icons.delete_outline, color: AppTheme.errorRed),
                onPressed: () => _showDeleteConfirmation(context, ref, screenshotPath),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFullScreenImage(
    BuildContext context,
    WidgetRef ref,
    String screenshotPath,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _FullScreenImageViewer(
          imagePath: screenshotPath,
          onDelete: () async {
            final screenshotService = ref.read(screenshotServiceProvider);
            await screenshotService.deleteScreenshot(screenshotPath);

            ref.read(screenshotsRefreshProvider.notifier).state++;
            ref.invalidate(savedScreenshotsProvider);

            if (context.mounted) {
              Navigator.pop(context);
            }
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    String screenshotPath,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: AppTheme.dialogShape,
        title: const Text('Delete Screenshot', style: AppTheme.dialogTitle),
        content: const Text(
          'Are you sure you want to delete this screenshot?',
          style: AppTheme.dialogContent,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: AppTheme.textButton,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final screenshotService = ref.read(screenshotServiceProvider);
              await screenshotService.deleteScreenshot(screenshotPath);
              ref.read(screenshotsRefreshProvider.notifier).state++;
              ref.invalidate(savedScreenshotsProvider);
            },
            style: TextButton.styleFrom(foregroundColor: AppTheme.errorRed),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  DateTime _extractDateTime(String fileName) {
    try {
      final timestamp = fileName.replaceAll('path_', '').replaceAll('.png', '');
      return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    } catch (e) {
      return DateTime.now();
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }
}

class _FullScreenImageViewer extends StatelessWidget {
  final String imagePath;
  final VoidCallback onDelete;

  const _FullScreenImageViewer({
    required this.imagePath,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: AppTheme.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: AppTheme.dialogShape,
                  title: const Text('Delete Screenshot', style: AppTheme.dialogTitle),
                  content: const Text(
                    'Are you sure you want to delete this screenshot?',
                    style: AppTheme.dialogContent,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: AppTheme.textButton,
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onDelete();
                      },
                      style: TextButton.styleFrom(foregroundColor: AppTheme.errorRed),
                      child: const Text('Delete'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.file(File(imagePath), fit: BoxFit.contain),
        ),
      ),
    );
  }
}