//
//  GraphQLNodes.swift
//  Clibgraphqlparser
//
//  Created by Ryan Billard on 2018-02-04.
//  Copyright © 2018 Ryan Billard. All rights reserved.
//

import Foundation

public enum GraphQLNodes {
	public class OperationDefinition {
		private let node: OpaquePointer
		
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var type: String {
			guard let cString = GraphQLAstOperationDefinition_get_operation(node) else { return "" }
			return String(cString: cString)
		}
		
		public var name: Name? {
			guard let ptr = GraphQLAstOperationDefinition_get_name(node) else { return nil }
			return Name(ptr)
		}
		
		public var selectionSet: SelectionSet? {
			guard let ptr = GraphQLAstOperationDefinition_get_selection_set(node) else { return nil }
			return SelectionSet(ptr)
		}
		
		public var variableDefinitionsSize: Int32 {
			return GraphQLAstOperationDefinition_get_variable_definitions_size(node)
		}
	}
	
	public class VariableDefinition {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var variable: Variable {
			let ptr = GraphQLAstVariableDefinition_get_variable(node)!
			return Variable(ptr)
		}
	}
	
	public class Variable {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstVariable_get_name(node)!
			return Name(ptr)
		}
	}
	
	public class SelectionSet {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var size: Int32 {
			return GraphQLAstSelectionSet_get_selections_size(node)
		}
	}
	
	public class Name {
		private let node: OpaquePointer
		
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var value: String {
			guard let cString = GraphQLAstName_get_value(node) else { return "" }
			return String(cString: cString)
		}
	}
	
	public class Selection {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
	}
	
	public class Field {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstField_get_name(node)!
			return Name(ptr)
		}
		
		public var alias: Name? {
			guard let ptr = GraphQLAstField_get_alias(node) else { return nil }
			return Name(ptr)
		}
		
		public var selectionSet: SelectionSet? {
			guard let ptr = GraphQLAstField_get_selection_set(node) else { return nil }
			return SelectionSet(ptr)
		}
		
		public var argumentsSize: Int32 {
			return GraphQLAstField_get_arguments_size(node)
		}
	}
	
	public class Argument {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstArgument_get_name(node)!
			return Name(ptr)
		}
	}
	
	public class FragmentSpread {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstFragmentSpread_get_name(node)!
			return Name(ptr)
		}
	}
	
	public class InlineFragment {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var typeCondition: NamedType {
			let ptr = GraphQLAstInlineFragment_get_type_condition(node)!
			return NamedType(ptr)
		}
	}
	
	public class FragmentDefinition {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstFragmentDefinition_get_name(node)!
			return Name(ptr)
		}
		
		public var typeCondition: NamedType {
			let ptr = GraphQLAstFragmentDefinition_get_type_condition(node)!
			return NamedType(ptr)
		}
	}
	
	public class Value {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
	}
	
	public class IntValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var value: String {
			let chars = GraphQLAstIntValue_get_value(node)!
			return String(cString: chars)
		}
	}
	
	public class FloatValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var value: String {
			let chars = GraphQLAstFloatValue_get_value(node)!
			return String(cString: chars)
		}
	}
	
	public class StringValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var value: String {
			let chars = GraphQLAstStringValue_get_value(node)!
			return String(cString: chars)
		}
	}
	
	public class BooleanValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var value: Bool {
			return GraphQLAstBooleanValue_get_value(node) == 1
		}
	}
	
	public class NullValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
	}
	
	public class EnumValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var value: String {
			return String(cString: GraphQLAstEnumValue_get_value(node))
		}
	}
	
	public class ListValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var size: Int32 {
			return GraphQLAstListValue_get_values_size(node)
		}
	}
	
	public class ObjectValue {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var fieldsSize: Int32 {
			return GraphQLAstObjectValue_get_fields_size(node)
		}
	}
	
	public class ObjectField {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstObjectField_get_name(node)!
			return Name(ptr)
		}
	}
	
	public class Directive {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
	}
	
	public class NamedType {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
		
		public var name: Name {
			let ptr = GraphQLAstNamedType_get_name(node)!
			return Name(ptr)
		}
	}
	
	public class ListType {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
	}
	
	public class NonNullType {
		private let node: OpaquePointer
		init(_ node: OpaquePointer) {
			self.node = node
		}
	}
}
