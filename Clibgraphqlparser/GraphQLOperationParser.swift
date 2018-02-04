//
//  GraphQLOperationParser.swift
//  Clibgraphqlparser
//
//  Created by Ryan Billard on 2018-02-04.
//  Copyright © 2018 Ryan Billard. All rights reserved.
//

import Foundation

public class GraphQLOperationParser {
	private var callbacks: GraphQLAstVisitorCallbacks
	private var node: OpaquePointer
	
	public init(graphQLString: String) {
		guard graphQLString.isEmpty == false else {
			fatalError("Empty GraphQL string provided")
		}
		var error: UnsafePointer<Int8>? = nil
		let result = withUnsafeMutablePointer(to: &error) { (errorPointer) -> OpaquePointer? in
			return graphql_parse_string(graphQLString, errorPointer)
		}
		if let result = result {
			node = result
		} else if let error = error {
			fatalError("Error when parsing GraphQL operations: \(String(cString: error))")
		} else {
			fatalError("Encountered unknown error when parsing GraphQL operations")
		}
		callbacks = GraphQLAstVisitorCallbacks()
		callbacks.visit_operation_definition = globalVisitOperationDefinition
		callbacks.end_visit_operation_definition = globalExitOperationDefinition
		callbacks.visit_variable_definition = globalVisitVariableDefinition
		callbacks.end_visit_variable_definition = globalExitVariableDefinition
		callbacks.visit_selection_set = globalVisitSelectionSet
		callbacks.end_visit_selection_set = globalExitSelectionSet
		callbacks.visit_field = globalVisitField
		callbacks.end_visit_field = globalExitField
		callbacks.visit_argument = globalVisitArgument
		callbacks.end_visit_argument = globalExitArgument
		callbacks.visit_fragment_spread = globalVisitFragmentSpread
		callbacks.end_visit_fragment_spread = globalExitFragmentSpread
		callbacks.visit_inline_fragment = globalVisitInlineFragment
		callbacks.end_visit_inline_fragment = globalExitInlineFragment
		callbacks.visit_fragment_definition = globalVisitFragmentDefinition
		callbacks.end_visit_fragment_definition = globalExitFragmentDefinition
		callbacks.visit_variable = globalVisitVariable
		callbacks.end_visit_variable = globalExitVariable
		callbacks.visit_int_value = globalVisitIntValue
		callbacks.end_visit_int_value = globalExitIntValue
		callbacks.visit_float_value = globalVisitFloatValue
		callbacks.end_visit_float_value = globalExitFloatValue
		callbacks.visit_string_value = globalVisitStringValue
		callbacks.end_visit_string_value = globalExitStringValue
		callbacks.visit_boolean_value = globalVisitBooleanValue
		callbacks.end_visit_boolean_value = globalExitBooleanValue
		callbacks.visit_null_value = globalVisitNullValue
		callbacks.end_visit_null_value = globalExitNullValue
		callbacks.visit_enum_value = globalVisitEnumValue
		callbacks.end_visit_enum_value = globalExitEnumValue
		callbacks.visit_list_value = globalVisitListValue
		callbacks.end_visit_list_value = globalExitListValue
		callbacks.visit_object_value = globalVisitObjectValue
		callbacks.end_visit_object_value = globalExitObjectValue
		callbacks.visit_object_field = globalVisitObjectField
		callbacks.end_visit_object_field = globalExitObjectField
		callbacks.visit_directive = globalVisitDirective
		callbacks.end_visit_directive = globalExitDirective
		callbacks.visit_named_type = globalVisitNamedType
		callbacks.end_visit_named_type = globalExitNamedType
		callbacks.visit_list_type = globalVisitListType
		callbacks.end_visit_list_type = globalExitListType
		callbacks.visit_non_null_type = globalVisitNonNullType
		callbacks.end_visit_non_null_type = globalExitNonNullType
	}
	
	deinit {
		graphql_node_free(node)
	}
	
	public func walk(with visitor: GraphQLBaseVisitor) {
		globalVisitor = visitor
		withUnsafePointer(to: &callbacks) { (callbacksPtr: UnsafePointer<GraphQLAstVisitorCallbacks>) -> Void in
			graphql_node_visit(node, callbacksPtr, nil)
		}
	}
}

// MARK: Global callbacks
// These transform the OpaquePointer into the proper GraphQLNodes type and call into the existing visitor instance.

private var globalVisitor: GraphQLBaseVisitor? = nil

private func globalVisitOperationDefinition(operationDefinition: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let operationDefinition = operationDefinition else { return 0 }
	globalVisitor?.visitOperationDefinition(operationDefinition: GraphQLNodes.OperationDefinition(operationDefinition))
	return 1
}
private func globalVisitVariableDefinition(variableDefinition: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let variableDefinition = variableDefinition else { return 0 }
	globalVisitor?.visitVariableDefinition(variableDefinition: GraphQLNodes.VariableDefinition(variableDefinition))
	return 1
}
private func globalVisitSelectionSet(selectionSet: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let selectionSet = selectionSet else { return 0 }
	globalVisitor?.visitSelectionSet(selectionSet: GraphQLNodes.SelectionSet(selectionSet))
	return 1
}
private func globalVisitField(field: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let field = field else { return 0 }
	globalVisitor?.visitField(field: GraphQLNodes.Field(field))
	return 1
}
private func globalVisitArgument(argument: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let argument = argument else { return 0 }
	globalVisitor?.visitArgument(argument: GraphQLNodes.Argument(argument))
	return 1
}
private func globalVisitFragmentSpread(fragmentSpread: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let fragmentSpread = fragmentSpread else { return 0 }
	globalVisitor?.visitFragmentSpread(fragmentSpread: GraphQLNodes.FragmentSpread(fragmentSpread))
	return 1
}
private func globalVisitInlineFragment(inlineFragment: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let inlineFragment = inlineFragment else { return 0 }
	globalVisitor?.visitInlineFragment(inlineFragment: GraphQLNodes.InlineFragment(inlineFragment))
	return 1
}
private func globalVisitFragmentDefinition(fragmentDefinition: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let fragmentDefinition = fragmentDefinition else { return 0 }
	globalVisitor?.visitFragmentDefinition(fragmentDefinition: GraphQLNodes.FragmentDefinition(fragmentDefinition))
	return 1
}
private func globalVisitValue(value: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let value = value else { return 0 }
	globalVisitor?.visitValue(value: GraphQLNodes.Value(value))
	return 1
}
private func globalVisitVariable(variable: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let variable = variable else { return 0 }
	globalVisitor?.visitVariable(variable: GraphQLNodes.Variable(variable))
	return 1
}
private func globalVisitIntValue(intValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let intValue = intValue else { return 0 }
	globalVisitor?.visitIntValue(intValue: GraphQLNodes.IntValue(intValue))
	return 1
}
private func globalVisitFloatValue(floatValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let floatValue = floatValue else { return 0 }
	globalVisitor?.visitFloatValue(floatValue: GraphQLNodes.FloatValue(floatValue))
	return 1
}
private func globalVisitStringValue(stringValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let stringValue = stringValue else { return 0 }
	globalVisitor?.visitStringValue(stringValue: GraphQLNodes.StringValue(stringValue))
	return 1
}
private func globalVisitBooleanValue(booleanValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let booleanValue = booleanValue else { return 0 }
	globalVisitor?.visitBooleanValue(booleanValue: GraphQLNodes.BooleanValue(booleanValue))
	return 1
}
private func globalVisitNullValue(nullValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let nullValue = nullValue else { return 0 }
	globalVisitor?.visitNullValue(nullValue: GraphQLNodes.NullValue(nullValue))
	return 1
}
private func globalVisitEnumValue(enumValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let enumValue = enumValue else { return 0 }
	globalVisitor?.visitEnumValue(enumValue: GraphQLNodes.EnumValue(enumValue))
	return 1
}
private func globalVisitListValue(listValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let listValue = listValue else { return 0 }
	globalVisitor?.visitListValue(listValue: GraphQLNodes.ListValue(listValue))
	return 1
}
private func globalVisitObjectValue(objectValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let objectValue = objectValue else { return 0 }
	globalVisitor?.visitObjectValue(objectValue: GraphQLNodes.ObjectValue(objectValue))
	return 1
}
private func globalVisitObjectField(objectField: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let objectField = objectField else { return 0 }
	globalVisitor?.visitObjectField(objectField: GraphQLNodes.ObjectField(objectField))
	return 1
}
private func globalVisitDirective(directive: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let directive = directive else { return 0 }
	globalVisitor?.visitDirective(directive: GraphQLNodes.Directive(directive))
	return 1
}
private func globalVisitNamedType(namedType: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let namedType = namedType else { return 0 }
	globalVisitor?.visitNamedType(namedType: GraphQLNodes.NamedType(namedType))
	return 1
}
private func globalVisitListType(listType: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let listType = listType else { return 0 }
	globalVisitor?.visitListType(listType: GraphQLNodes.ListType(listType))
	return 1
}
private func globalVisitNonNullType(nonNullType: OpaquePointer?, userData: UnsafeMutableRawPointer?) -> Int32 {
	guard let nonNullType = nonNullType else { return 0 }
	globalVisitor?.visitNonNullType(nonNullType: GraphQLNodes.NonNullType(nonNullType))
	return 1
}
private func globalExitOperationDefinition(operationDefinition: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let operationDefinition = operationDefinition else { return }
	globalVisitor?.exitOperationDefinition(operationDefinition: GraphQLNodes.OperationDefinition(operationDefinition))
}
private func globalExitVariableDefinition(variableDefinition: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let variableDefinition = variableDefinition else { return }
	globalVisitor?.exitVariableDefinition(variableDefinition: GraphQLNodes.VariableDefinition(variableDefinition))
}
private func globalExitSelectionSet(selectionSet: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let selectionSet = selectionSet else { return }
	globalVisitor?.exitSelectionSet(selectionSet: GraphQLNodes.SelectionSet(selectionSet))
}
private func globalExitField(field: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let field = field else { return }
	globalVisitor?.exitField(field: GraphQLNodes.Field(field))
}
private func globalExitArgument(argument: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let argument = argument else { return }
	globalVisitor?.exitArgument(argument: GraphQLNodes.Argument(argument))
}
private func globalExitFragmentSpread(fragmentSpread: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let fragmentSpread = fragmentSpread else { return }
	globalVisitor?.exitFragmentSpread(fragmentSpread: GraphQLNodes.FragmentSpread(fragmentSpread))
}
private func globalExitInlineFragment(inlineFragment: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let inlineFragment = inlineFragment else { return }
	globalVisitor?.exitInlineFragment(inlineFragment: GraphQLNodes.InlineFragment(inlineFragment))
}
private func globalExitFragmentDefinition(fragmentDefinition: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let fragmentDefinition = fragmentDefinition else { return }
	globalVisitor?.exitFragmentDefinition(fragmentDefinition: GraphQLNodes.FragmentDefinition(fragmentDefinition))
}
private func globalExitValue(value: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let value = value else { return }
	globalVisitor?.exitValue(value: GraphQLNodes.Value(value))
}
private func globalExitVariable(variable: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let variable = variable else { return }
	globalVisitor?.exitVariable(variable: GraphQLNodes.Variable(variable))
}
private func globalExitIntValue(intValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let intValue = intValue else { return }
	globalVisitor?.exitIntValue(intValue: GraphQLNodes.IntValue(intValue))
}
private func globalExitFloatValue(floatValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let floatValue = floatValue else { return }
	globalVisitor?.exitFloatValue(floatValue: GraphQLNodes.FloatValue(floatValue))
}
private func globalExitStringValue(stringValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let stringValue = stringValue else { return }
	globalVisitor?.exitStringValue(stringValue: GraphQLNodes.StringValue(stringValue))
}
private func globalExitBooleanValue(booleanValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let booleanValue = booleanValue else { return }
	globalVisitor?.exitBooleanValue(booleanValue: GraphQLNodes.BooleanValue(booleanValue))
}
private func globalExitNullValue(nullValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let nullValue = nullValue else { return }
	globalVisitor?.exitNullValue(nullValue: GraphQLNodes.NullValue(nullValue))
}
private func globalExitEnumValue(enumValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let enumValue = enumValue else { return }
	globalVisitor?.exitEnumValue(enumValue: GraphQLNodes.EnumValue(enumValue))
}
private func globalExitListValue(listValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let listValue = listValue else { return }
	globalVisitor?.exitListValue(listValue: GraphQLNodes.ListValue(listValue))
}
private func globalExitObjectValue(objectValue: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let objectValue = objectValue else { return }
	globalVisitor?.exitObjectValue(objectValue: GraphQLNodes.ObjectValue(objectValue))
}
private func globalExitObjectField(objectField: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let objectField = objectField else { return }
	globalVisitor?.exitObjectField(objectField: GraphQLNodes.ObjectField(objectField))
}
private func globalExitDirective(directive: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let directive = directive else { return }
	globalVisitor?.exitDirective(directive: GraphQLNodes.Directive(directive))
}
private func globalExitNamedType(namedType: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let namedType = namedType else { return }
	globalVisitor?.exitNamedType(namedType: GraphQLNodes.NamedType(namedType))
}
private func globalExitListType(listType: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let listType = listType else { return }
	globalVisitor?.exitListType(listType: GraphQLNodes.ListType(listType))
}
private func globalExitNonNullType(nonNullType: OpaquePointer?, userData: UnsafeMutableRawPointer?) {
	guard let nonNullType = nonNullType else { return }
	globalVisitor?.exitNonNullType(nonNullType: GraphQLNodes.NonNullType(nonNullType))
}
