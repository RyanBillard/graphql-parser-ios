//
//  GraphQLBaseVisitor.swift
//  Clibgraphqlparser
//
//  Created by Ryan Billard on 2018-02-04.
//  Copyright © 2018 Ryan Billard. All rights reserved.
//

import Foundation

open class GraphQLBaseVisitor {
	public init() { }

	open func visitOperationDefinition(operationDefinition: GraphQLNodes.OperationDefinition) {}
	
	open func exitOperationDefinition(operationDefinition: GraphQLNodes.OperationDefinition) {}
	
	open func visitVariableDefinition(variableDefinition: GraphQLNodes.VariableDefinition) {}
	
	open func exitVariableDefinition(variableDefinition: GraphQLNodes.VariableDefinition) {}
	
	open func visitSelectionSet(selectionSet: GraphQLNodes.SelectionSet) {}
	
	open func exitSelectionSet(selectionSet: GraphQLNodes.SelectionSet) {}
	
	open func visitField(field: GraphQLNodes.Field) {}
	
	open func exitField(field: GraphQLNodes.Field) {}
	
	open func visitFragmentSpread(fragmentSpread: GraphQLNodes.FragmentSpread) {}
	
	open func visitArgument(argument: GraphQLNodes.Argument) {}
	
	open func visitInlineFragment(inlineFragment: GraphQLNodes.InlineFragment) {}
	
	open func visitFragmentDefinition(fragmentDefinition: GraphQLNodes.FragmentDefinition) {}
	
	open func exitFragmentDefinition(fragmentDefinition: GraphQLNodes.FragmentDefinition) {}
	
	open func exitNamedType(namedType: GraphQLNodes.NamedType) {}
	
	open func exitListType(listType: GraphQLNodes.ListType) {}
	
	open func exitNonNullType(nonNullType: GraphQLNodes.NonNullType) {}
	
	open func visitNamedType(namedType: GraphQLNodes.NamedType) {}
	
	open func visitValue(value: GraphQLNodes.Value) {}
	
	open func visitVariable(variable: GraphQLNodes.Variable) {}
	
	open func visitIntValue(intValue: GraphQLNodes.IntValue) {}
	
	open func visitFloatValue(floatValue: GraphQLNodes.FloatValue) {}
	
	open func visitStringValue(stringValue: GraphQLNodes.StringValue) {}
	
	open func visitBooleanValue(booleanValue: GraphQLNodes.BooleanValue) {}
	
	open func visitNullValue(nullValue: GraphQLNodes.NullValue) {}
	
	open func visitEnumValue(enumValue: GraphQLNodes.EnumValue) {}
	
	open func visitListValue(listValue: GraphQLNodes.ListValue) {}
	
	open func visitObjectValue(objectValue: GraphQLNodes.ObjectValue) {}
	
	open func visitObjectField(objectField: GraphQLNodes.ObjectField) {}
	
	open func visitDirective(directive: GraphQLNodes.Directive) {}
	
	open func visitListType(listType: GraphQLNodes.ListType) {}
	
	open func visitNonNullType(nonNullType: GraphQLNodes.NonNullType) {}
	
	open func exitArgument(argument: GraphQLNodes.Argument) {}
	
	open func exitFragmentSpread(fragmentSpread: GraphQLNodes.FragmentSpread) {}
	
	open func exitInlineFragment(inlineFragment: GraphQLNodes.InlineFragment) {}
	
	open func exitValue(value: GraphQLNodes.Value) {}
	
	open func exitVariable(variable: GraphQLNodes.Variable) {}
	
	open func exitIntValue(intValue: GraphQLNodes.IntValue) {}
	
	open func exitFloatValue(floatValue: GraphQLNodes.FloatValue) {}
	
	open func exitStringValue(stringValue: GraphQLNodes.StringValue) {}
	
	open func exitBooleanValue(booleanValue: GraphQLNodes.BooleanValue) {}
	
	open func exitNullValue(nullValue: GraphQLNodes.NullValue) {}
	
	open func exitEnumValue(enumValue: GraphQLNodes.EnumValue) {}
	
	open func exitListValue(listValue: GraphQLNodes.ListValue) {}
	
	open func exitObjectValue(objectValue: GraphQLNodes.ObjectValue) {}
	
	open func exitObjectField(objectField: GraphQLNodes.ObjectField) {}
	
	open func exitDirective(directive: GraphQLNodes.Directive) {}
}
