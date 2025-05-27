import 'package:ai_learning_app/core/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspace_core/myspace_core.dart';
import 'package:myspace_ui/myspace_ui.dart';

class PlanMilestone extends StatelessWidget {
  const PlanMilestone({
    super.key,
    required this.milestone,
    required this.onLaunchUrl,
  });

  final Milestone milestone;
  final Future<Result<void>> Function(String url) onLaunchUrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _card(context, [
            _title(context, milestone.title),
            const SizedBox(height: 4),
            Text(milestone.description, style: context.textTheme.bodyMedium),
            if (milestone.resourceUrl != null) ...[
              const SizedBox(height: 12),
              _title(context, 'Read More'),
              ButtonComponent.text(
                text: milestone.resourceUrl!,
                icon: Icons.link_rounded,
                // style: TextStyle(
                // decoration: TextDecoration.underline,
                // decorationColor: context.colorScheme.primary,
                // ),
                onPressed: () async {
                  final result = await onLaunchUrl(milestone.resourceUrl!);
                  result.fold((_) {}, (e) {
                    ErrorDialog.show(e.toString());
                  });
                },
              ),
            ],
          ]),
          if (milestone.substeps.isNotEmpty)
            _card(context, [
              _title(context, 'Key Notes'),
              //substeps
              for (var substep in milestone.substeps)
                Builder(
                  builder: (context) {
                    final actionHint = substep.actionHint;
                    return ListTile(
                      contentPadding: EdgeInsets.all(0),
                      visualDensity: VisualDensity.compact,
                      // leading: Icon(Icons.star_rounded), //todo: use action icon
                      leading: Icon(Icons.circle, size: 8),
                      minLeadingWidth: 4,
                      onTap:
                          substep.detailUrl != null
                              ? () async {
                                final result = await onLaunchUrl(
                                  substep.detailUrl!,
                                );
                                result.fold((_) {}, (e) {
                                  ErrorDialog.show(e.toString());
                                });
                              }
                              : null,
                      trailing:
                          substep.detailUrl != null
                              ? Icon(Icons.chevron_right)
                              : null,
                      title: Text(substep.title),
                      titleTextStyle: context.textTheme.titleSmall,
                      subtitle:
                          actionHint != null ? Text(actionHint.value) : null,
                      subtitleTextStyle: context.textTheme.bodySmall!.copyWith(
                        // color: context.colorScheme.outlineVariant,
                      ),
                    );
                  },
                ),
            ]),
          if (milestone.canGenerateImage)
            _card(context, [
              _title(context, 'Generate Image'),
              const SizedBox(height: 4),
              ButtonComponent.primary(
                text: 'Generate Image',
                icon: Icons.image_rounded,
                onPressed: () {},
              ).sized(width: double.infinity),
            ]),

          if (milestone.quiz != null && milestone.quiz!.choices.isNotEmpty)
            _card(context, [
              _title(context, 'Quiz'),
              const SizedBox(height: 4),
              _Quiz(quiz: milestone.quiz!),
            ]),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, List<Widget> children) {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _title(BuildContext context, String title) {
    return Text(title, style: context.textTheme.titleMedium);
  }
}

class _Quiz extends StatefulWidget {
  const _Quiz({required this.quiz});

  final Quiz quiz;

  @override
  State<_Quiz> createState() => _QuizState();
}

class _QuizState extends State<_Quiz> with AutomaticKeepAliveClientMixin {
  bool _isExpanded = false;
  final List<String> _selectedChoices = [];
  String get correctChoice =>
      widget.quiz.choices[widget.quiz.correctAnswerIndex];
  bool get isCorrectSelected => _selectedChoices.contains(correctChoice);

  void _onChoiceSelected(BuildContext context, String choice) {
    if (_selectedChoices.length == widget.quiz.choices.length) return;
    if (isCorrectSelected) return;
    setState(() {
      _selectedChoices.add(choice);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(widget.quiz.question),
        const SizedBox(height: 4),
        if (_isExpanded) ...[
          for (int i = 0; i < widget.quiz.choices.length; i++)
            _buildChoice(context, i),
        ] else
          ButtonComponent.text(
            text: 'Reveal Choices',
            icon: Icons.visibility_rounded,
            onPressed: () {
              setState(() {
                _isExpanded = true;
              });
            },
          ),
      ],
    );
  }

  Widget _buildChoice(BuildContext context, int index) {
    final choice = widget.quiz.choices[index];
    final isCorrect =
        index == widget.quiz.correctAnswerIndex &&
        _selectedChoices.contains(choice);
    final isWrong =
        index != widget.quiz.correctAnswerIndex &&
        _selectedChoices.contains(choice);
    return GestureDetector(
      onTap: () {
        _onChoiceSelected(context, choice);
      },
      child: Opacity(
        opacity: isCorrectSelected && !isCorrect ? .5 : 1,
        child: AnimatedContainer(
          margin: EdgeInsets.symmetric(vertical: 2),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          duration: Durations.short4,
          decoration: BoxDecoration(
            borderRadius: context.borderRadius,
            border: Border.all(
              color:
                  isCorrect
                      ? Colors.green
                      : isWrong
                      ? context.colorScheme.error
                      : Colors.grey.shade300,
            ),
            color:
                isCorrect
                    ? Colors.green.withOpacity(.1)
                    : isWrong
                    ? context.colorScheme.error.withOpacity(.1)
                    : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  choice,
                  style: TextStyle(
                    color: isCorrect ? Colors.green : null,
                    fontWeight: isCorrect ? FontWeight.w600 : null,
                  ),
                ),
              ),
              Icon(
                isCorrect
                    ? Icons.check_rounded
                    : isWrong
                    ? Icons.close_rounded
                    : null,
                size: 15,
                color:
                    isCorrect
                        ? Colors.green
                        : isWrong
                        ? context.colorScheme.error
                        : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
