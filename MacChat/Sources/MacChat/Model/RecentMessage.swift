import Foundation

struct RecentMessage: Identifiable, Equatable {
  let id = UUID()
  let lastMsg: String
  let lastMsgTime: String
  let pendingMsgs: String
  let userName: String
  let userImage: String
  let allMsgs: [Message]
}

var kRecentMsgs: [RecentMessage] = [
  RecentMessage(
    lastMsg: "Apple Tech",
    lastMsgTime: "15:00",
    pendingMsgs: "9",
    userName: "Jenna Ezarik",
    userImage: "jenna",
    allMsgs: kEachmsg.shuffled()
  ),
  RecentMessage(
    lastMsg: "New Album Is Going To Be Released!!!!",
    lastMsgTime: "14:32",
    pendingMsgs: "2",
    userName: "Taylor",
    userImage: "p0",
    allMsgs: kEachmsg.shuffled()
  )
  ,RecentMessage(
    lastMsg: "Hi this is Steve Rogers !!!",
    lastMsgTime: "14:35",
    pendingMsgs: "2",
    userName: "Steve",
    userImage: "p1",
    allMsgs: kEachmsg.shuffled()
  )
  ,RecentMessage(
    lastMsg: "New Tutorial From Kavosft !!!",
    lastMsgTime: "14:39",
    pendingMsgs: "1",
    userName: "Kavsoft",
    userImage: "p2",
    allMsgs: kEachmsg.shuffled()
  )
  ,RecentMessage(
    lastMsg: "New SwiftUI API Is Released!!!!",
    lastMsgTime: "14:50",
    pendingMsgs: "",
    userName: "SwiftUI",
    userImage: "p3",
    allMsgs: kEachmsg.shuffled()
  ),
  RecentMessage(
    lastMsg: "Founder Of Microsoft !!!",
    lastMsgTime: "14:50",
    pendingMsgs: "",
    userName: "Bill Gates",
    userImage: "p5",
    allMsgs: kEachmsg.shuffled()
  ),
  RecentMessage(
    lastMsg: "Founder Of Amazon",
    lastMsgTime: "14:39",
    pendingMsgs: "1",
    userName: "Jeff",
    userImage: "p6",
    allMsgs: kEachmsg.shuffled()
  ),
  RecentMessage(
    lastMsg: "Released New iPhone 11!!!",
    lastMsgTime: "14:32",
    pendingMsgs: "2",
    userName: "Tim Cook",
    userImage: "p7",
    allMsgs: kEachmsg.shuffled()
  )
]

