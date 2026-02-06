import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../core/theme/app_theme.dart';
import '../providers/providers.dart';

/// Recordings tab content for Walking History
class RecordingsTab extends ConsumerStatefulWidget {
  const RecordingsTab({super.key});

  @override
  ConsumerState<RecordingsTab> createState() => _RecordingsTabState();
}

class _RecordingsTabState extends ConsumerState<RecordingsTab> {
  List<String> recordings = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecordings();
  }

  Future<void> _loadRecordings() async {
    setState(() => isLoading = true);
    final service = ref.read(screenRecorderServiceProvider);
    final loadedRecordings = await service.getSavedRecordings();
    setState(() {
      recordings = loadedRecordings;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryPurple),
        ),
      );
    }

    if (recordings.isEmpty) {
      return _buildEmptyState();
    }

    return _buildRecordingsList();
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videocam_off, size: 80, color: Colors.grey[400]),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'No recordings yet',
            style: AppTheme.bodyLarge.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textLight,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          const Text(
            'Start walking to record your sessions',
            style: AppTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildRecordingsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      itemCount: recordings.length,
      itemBuilder: (context, index) {
        return _RecordingCard(
          filePath: recordings[index],
          onDelete: () async {
            final service = ref.read(screenRecorderServiceProvider);
            await service.deleteRecording(recordings[index]);
            _loadRecordings();
          },
        );
      },
    );
  }
}

class _RecordingCard extends StatelessWidget {
  final String filePath;
  final VoidCallback onDelete;

  const _RecordingCard({
    required this.filePath,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final fileName = filePath.split('/').last;
    final file = File(filePath);
    final dateTime = _extractDateTime(fileName);

    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _VideoPlayerScreen(filePath: filePath),
            ),
          );
        },
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Row(
            children: [
              // Video Icon
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppTheme.primaryPurple.withValues(alpha:0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: const Icon(
                  Icons.videocam,
                  color: AppTheme.primaryPurple,
                  size: 40,
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
                    Row(
                      children: [
                        // Time icon and placeholder
                        const Icon(
                          Icons.timer_rounded,
                          size: 16,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '--',
                          style: AppTheme.bodySmall,
                        ),

                        const SizedBox(width: AppTheme.spacingM),

                        // Distance icon and placeholder
                        const Icon(
                          Icons.straighten_rounded,
                          size: 16,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          '--',
                          style: AppTheme.bodySmall,
                        ),

                        const SizedBox(width: AppTheme.spacingM),

                        // File size
                        const Icon(
                          Icons.storage,
                          size: 16,
                          color: AppTheme.textLight,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _formatFileSize(file.lengthSync()),
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
                onPressed: () => _showDeleteConfirmation(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: AppTheme.dialogShape,
        title: const Text('Delete Recording', style: AppTheme.dialogTitle),
        content: const Text(
          'Are you sure you want to delete this recording?',
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
  }

  DateTime _extractDateTime(String fileName) {
    try {
      final timestamp = fileName.replaceAll('recording_', '').replaceAll('.mp4', '');
      return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    } catch (e) {
      return DateTime.now();
    }
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return '${months[date.month - 1]} ${date.day.toString().padLeft(2, '0')}, ${date.year}';
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }
}

class _VideoPlayerScreen extends StatefulWidget {
  final String filePath;

  const _VideoPlayerScreen({required this.filePath});

  @override
  State<_VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<_VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.file(File(widget.filePath));

    try {
      await _controller.initialize();
      setState(() => _isInitialized = true);
      _controller.play();
      _controller.setLooping(true);
    } catch (e) {
      debugPrint('Error initializing video: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        title: const Text('Recording', style: TextStyle(color: AppTheme.white)),
      ),
      body: Center(
        child: _isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white),
              ),
      ),
      floatingActionButton: _isInitialized
          ? FloatingActionButton(
              backgroundColor: AppTheme.primaryPurple,
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
              },
              child: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: AppTheme.white,
              ),
            )
          : null,
    );
  }
}