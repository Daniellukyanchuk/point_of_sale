// Code generated by protoc-gen-go. DO NOT EDIT.
// versions:
// 	protoc-gen-go v1.27.1
// 	protoc        v3.19.4
// source: events_resend.proto

package rpc

import (
	protoreflect "google.golang.org/protobuf/reflect/protoreflect"
	protoimpl "google.golang.org/protobuf/runtime/protoimpl"
	reflect "reflect"
	sync "sync"
)

const (
	// Verify that this generated code is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(20 - protoimpl.MinVersion)
	// Verify that runtime/protoimpl is sufficiently up-to-date.
	_ = protoimpl.EnforceVersion(protoimpl.MaxVersion - 20)
)

type EventsResendRequest struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	// The ID of the event to resend.
	EventId string `protobuf:"bytes,1,opt,name=event_id,json=eventId,proto3" json:"event_id,omitempty"`
	// Resend the event to the given Stripe account. This is useful when testing a Connect platform.
	Account string `protobuf:"bytes,2,opt,name=account,proto3" json:"account,omitempty"`
	// Additional data to send with an API request. Supports setting nested values
	// (e.g nested[param]=value).
	Data []string `protobuf:"bytes,3,rep,name=data,proto3" json:"data,omitempty"`
	// Response attributes to expand inline (target nested values with nested[param]=value).
	Expand []string `protobuf:"bytes,4,rep,name=expand,proto3" json:"expand,omitempty"`
	// Set an idempotency key for the request, preventing the same request from replaying within 24
	// hours.
	Idempotency string `protobuf:"bytes,5,opt,name=idempotency,proto3" json:"idempotency,omitempty"`
	// Make a live request (by default, runs in test mode).
	Live bool `protobuf:"varint,6,opt,name=live,proto3" json:"live,omitempty"`
	// Specify the Stripe account to use for this request.
	StripeAccount string `protobuf:"bytes,7,opt,name=stripe_account,json=stripeAccount,proto3" json:"stripe_account,omitempty"`
	// Specify the Stripe API version to use for this request.
	Version string `protobuf:"bytes,8,opt,name=version,proto3" json:"version,omitempty"`
	// Resend the event to the given webhook endpoint ID.
	WebhookEndpoint string `protobuf:"bytes,9,opt,name=webhook_endpoint,json=webhookEndpoint,proto3" json:"webhook_endpoint,omitempty"`
}

func (x *EventsResendRequest) Reset() {
	*x = EventsResendRequest{}
	if protoimpl.UnsafeEnabled {
		mi := &file_events_resend_proto_msgTypes[0]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *EventsResendRequest) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*EventsResendRequest) ProtoMessage() {}

func (x *EventsResendRequest) ProtoReflect() protoreflect.Message {
	mi := &file_events_resend_proto_msgTypes[0]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use EventsResendRequest.ProtoReflect.Descriptor instead.
func (*EventsResendRequest) Descriptor() ([]byte, []int) {
	return file_events_resend_proto_rawDescGZIP(), []int{0}
}

func (x *EventsResendRequest) GetEventId() string {
	if x != nil {
		return x.EventId
	}
	return ""
}

func (x *EventsResendRequest) GetAccount() string {
	if x != nil {
		return x.Account
	}
	return ""
}

func (x *EventsResendRequest) GetData() []string {
	if x != nil {
		return x.Data
	}
	return nil
}

func (x *EventsResendRequest) GetExpand() []string {
	if x != nil {
		return x.Expand
	}
	return nil
}

func (x *EventsResendRequest) GetIdempotency() string {
	if x != nil {
		return x.Idempotency
	}
	return ""
}

func (x *EventsResendRequest) GetLive() bool {
	if x != nil {
		return x.Live
	}
	return false
}

func (x *EventsResendRequest) GetStripeAccount() string {
	if x != nil {
		return x.StripeAccount
	}
	return ""
}

func (x *EventsResendRequest) GetVersion() string {
	if x != nil {
		return x.Version
	}
	return ""
}

func (x *EventsResendRequest) GetWebhookEndpoint() string {
	if x != nil {
		return x.WebhookEndpoint
	}
	return ""
}

type EventsResendResponse struct {
	state         protoimpl.MessageState
	sizeCache     protoimpl.SizeCache
	unknownFields protoimpl.UnknownFields

	StripeEvent *StripeEvent `protobuf:"bytes,1,opt,name=stripe_event,json=stripeEvent,proto3" json:"stripe_event,omitempty"`
}

func (x *EventsResendResponse) Reset() {
	*x = EventsResendResponse{}
	if protoimpl.UnsafeEnabled {
		mi := &file_events_resend_proto_msgTypes[1]
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		ms.StoreMessageInfo(mi)
	}
}

func (x *EventsResendResponse) String() string {
	return protoimpl.X.MessageStringOf(x)
}

func (*EventsResendResponse) ProtoMessage() {}

func (x *EventsResendResponse) ProtoReflect() protoreflect.Message {
	mi := &file_events_resend_proto_msgTypes[1]
	if protoimpl.UnsafeEnabled && x != nil {
		ms := protoimpl.X.MessageStateOf(protoimpl.Pointer(x))
		if ms.LoadMessageInfo() == nil {
			ms.StoreMessageInfo(mi)
		}
		return ms
	}
	return mi.MessageOf(x)
}

// Deprecated: Use EventsResendResponse.ProtoReflect.Descriptor instead.
func (*EventsResendResponse) Descriptor() ([]byte, []int) {
	return file_events_resend_proto_rawDescGZIP(), []int{1}
}

func (x *EventsResendResponse) GetStripeEvent() *StripeEvent {
	if x != nil {
		return x.StripeEvent
	}
	return nil
}

var File_events_resend_proto protoreflect.FileDescriptor

var file_events_resend_proto_rawDesc = []byte{
	0x0a, 0x13, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x73, 0x5f, 0x72, 0x65, 0x73, 0x65, 0x6e, 0x64, 0x2e,
	0x70, 0x72, 0x6f, 0x74, 0x6f, 0x12, 0x03, 0x72, 0x70, 0x63, 0x1a, 0x0c, 0x63, 0x6f, 0x6d, 0x6d,
	0x6f, 0x6e, 0x2e, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x22, 0x98, 0x02, 0x0a, 0x13, 0x45, 0x76, 0x65,
	0x6e, 0x74, 0x73, 0x52, 0x65, 0x73, 0x65, 0x6e, 0x64, 0x52, 0x65, 0x71, 0x75, 0x65, 0x73, 0x74,
	0x12, 0x19, 0x0a, 0x08, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x5f, 0x69, 0x64, 0x18, 0x01, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x07, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x49, 0x64, 0x12, 0x18, 0x0a, 0x07, 0x61,
	0x63, 0x63, 0x6f, 0x75, 0x6e, 0x74, 0x18, 0x02, 0x20, 0x01, 0x28, 0x09, 0x52, 0x07, 0x61, 0x63,
	0x63, 0x6f, 0x75, 0x6e, 0x74, 0x12, 0x12, 0x0a, 0x04, 0x64, 0x61, 0x74, 0x61, 0x18, 0x03, 0x20,
	0x03, 0x28, 0x09, 0x52, 0x04, 0x64, 0x61, 0x74, 0x61, 0x12, 0x16, 0x0a, 0x06, 0x65, 0x78, 0x70,
	0x61, 0x6e, 0x64, 0x18, 0x04, 0x20, 0x03, 0x28, 0x09, 0x52, 0x06, 0x65, 0x78, 0x70, 0x61, 0x6e,
	0x64, 0x12, 0x20, 0x0a, 0x0b, 0x69, 0x64, 0x65, 0x6d, 0x70, 0x6f, 0x74, 0x65, 0x6e, 0x63, 0x79,
	0x18, 0x05, 0x20, 0x01, 0x28, 0x09, 0x52, 0x0b, 0x69, 0x64, 0x65, 0x6d, 0x70, 0x6f, 0x74, 0x65,
	0x6e, 0x63, 0x79, 0x12, 0x12, 0x0a, 0x04, 0x6c, 0x69, 0x76, 0x65, 0x18, 0x06, 0x20, 0x01, 0x28,
	0x08, 0x52, 0x04, 0x6c, 0x69, 0x76, 0x65, 0x12, 0x25, 0x0a, 0x0e, 0x73, 0x74, 0x72, 0x69, 0x70,
	0x65, 0x5f, 0x61, 0x63, 0x63, 0x6f, 0x75, 0x6e, 0x74, 0x18, 0x07, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x0d, 0x73, 0x74, 0x72, 0x69, 0x70, 0x65, 0x41, 0x63, 0x63, 0x6f, 0x75, 0x6e, 0x74, 0x12, 0x18,
	0x0a, 0x07, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x18, 0x08, 0x20, 0x01, 0x28, 0x09, 0x52,
	0x07, 0x76, 0x65, 0x72, 0x73, 0x69, 0x6f, 0x6e, 0x12, 0x29, 0x0a, 0x10, 0x77, 0x65, 0x62, 0x68,
	0x6f, 0x6f, 0x6b, 0x5f, 0x65, 0x6e, 0x64, 0x70, 0x6f, 0x69, 0x6e, 0x74, 0x18, 0x09, 0x20, 0x01,
	0x28, 0x09, 0x52, 0x0f, 0x77, 0x65, 0x62, 0x68, 0x6f, 0x6f, 0x6b, 0x45, 0x6e, 0x64, 0x70, 0x6f,
	0x69, 0x6e, 0x74, 0x22, 0x4b, 0x0a, 0x14, 0x45, 0x76, 0x65, 0x6e, 0x74, 0x73, 0x52, 0x65, 0x73,
	0x65, 0x6e, 0x64, 0x52, 0x65, 0x73, 0x70, 0x6f, 0x6e, 0x73, 0x65, 0x12, 0x33, 0x0a, 0x0c, 0x73,
	0x74, 0x72, 0x69, 0x70, 0x65, 0x5f, 0x65, 0x76, 0x65, 0x6e, 0x74, 0x18, 0x01, 0x20, 0x01, 0x28,
	0x0b, 0x32, 0x10, 0x2e, 0x72, 0x70, 0x63, 0x2e, 0x53, 0x74, 0x72, 0x69, 0x70, 0x65, 0x45, 0x76,
	0x65, 0x6e, 0x74, 0x52, 0x0b, 0x73, 0x74, 0x72, 0x69, 0x70, 0x65, 0x45, 0x76, 0x65, 0x6e, 0x74,
	0x42, 0x22, 0x5a, 0x20, 0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2e, 0x63, 0x6f, 0x6d, 0x2f, 0x73,
	0x74, 0x72, 0x69, 0x70, 0x65, 0x2f, 0x73, 0x74, 0x72, 0x69, 0x70, 0x65, 0x2d, 0x63, 0x6c, 0x69,
	0x2f, 0x72, 0x70, 0x63, 0x62, 0x06, 0x70, 0x72, 0x6f, 0x74, 0x6f, 0x33,
}

var (
	file_events_resend_proto_rawDescOnce sync.Once
	file_events_resend_proto_rawDescData = file_events_resend_proto_rawDesc
)

func file_events_resend_proto_rawDescGZIP() []byte {
	file_events_resend_proto_rawDescOnce.Do(func() {
		file_events_resend_proto_rawDescData = protoimpl.X.CompressGZIP(file_events_resend_proto_rawDescData)
	})
	return file_events_resend_proto_rawDescData
}

var file_events_resend_proto_msgTypes = make([]protoimpl.MessageInfo, 2)
var file_events_resend_proto_goTypes = []interface{}{
	(*EventsResendRequest)(nil),  // 0: rpc.EventsResendRequest
	(*EventsResendResponse)(nil), // 1: rpc.EventsResendResponse
	(*StripeEvent)(nil),          // 2: rpc.StripeEvent
}
var file_events_resend_proto_depIdxs = []int32{
	2, // 0: rpc.EventsResendResponse.stripe_event:type_name -> rpc.StripeEvent
	1, // [1:1] is the sub-list for method output_type
	1, // [1:1] is the sub-list for method input_type
	1, // [1:1] is the sub-list for extension type_name
	1, // [1:1] is the sub-list for extension extendee
	0, // [0:1] is the sub-list for field type_name
}

func init() { file_events_resend_proto_init() }
func file_events_resend_proto_init() {
	if File_events_resend_proto != nil {
		return
	}
	file_common_proto_init()
	if !protoimpl.UnsafeEnabled {
		file_events_resend_proto_msgTypes[0].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*EventsResendRequest); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
		file_events_resend_proto_msgTypes[1].Exporter = func(v interface{}, i int) interface{} {
			switch v := v.(*EventsResendResponse); i {
			case 0:
				return &v.state
			case 1:
				return &v.sizeCache
			case 2:
				return &v.unknownFields
			default:
				return nil
			}
		}
	}
	type x struct{}
	out := protoimpl.TypeBuilder{
		File: protoimpl.DescBuilder{
			GoPackagePath: reflect.TypeOf(x{}).PkgPath(),
			RawDescriptor: file_events_resend_proto_rawDesc,
			NumEnums:      0,
			NumMessages:   2,
			NumExtensions: 0,
			NumServices:   0,
		},
		GoTypes:           file_events_resend_proto_goTypes,
		DependencyIndexes: file_events_resend_proto_depIdxs,
		MessageInfos:      file_events_resend_proto_msgTypes,
	}.Build()
	File_events_resend_proto = out.File
	file_events_resend_proto_rawDesc = nil
	file_events_resend_proto_goTypes = nil
	file_events_resend_proto_depIdxs = nil
}
