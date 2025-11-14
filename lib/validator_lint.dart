import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/error/listener.dart';
import 'package:custom_lint_builder/custom_lint_builder.dart';

PluginBase createPlugin() => _ValidatorLint();

class _ValidatorLint extends PluginBase {
  @override
  List<LintRule> getLintRules(CustomLintConfigs configs) => [
    ValidatorMissingRule(),
  ];
}

class ValidatorMissingRule extends DartLintRule {
  ValidatorMissingRule()
    : super(
        code: LintCode(
          name: 'validator_missing',
          problemMessage: 'Validator is missing',
          correctionMessage: 'Add a validator to the field',
        ),
      );

  @override
  void run(
    CustomLintResolver resolver,
    ErrorReporter reporter,
    CustomLintContext context,
  ) {
    context.registry.addInstanceCreationExpression((node) {
      final type = node.constructorName.type.type;
      if (type == null) return;

      final typeName = type.toString();
      if (typeName == 'TextFormField') {
        if (!_hasValidator(node)) {
          reporter.atToken(node.constructorName.beginToken, code);
        }
      }
    });
  }

  bool _hasValidator(InstanceCreationExpression node) {
    for (final argument in node.argumentList.arguments) {
      if (argument is NamedExpression) {
        final name = argument.name.label.name;
        if (name == 'validator') {
          return true;
        }
      }
    }
    return false;
  }
}
