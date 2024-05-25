import Map "mo:base/HashMap";
import Hash "mo:base/Hash";
import Nat "mo:base/Nat";
import Iter "mo:base/Iter";
import Text "mo:base/Text";
import Time "mo:base/Time";
import Principal "mo:base/Principal";



actor telephoners {

  type Call = {
    author : Principal;
    content : Text;
    timestamp : Time.Time;
  };

    func natHash(n : Nat) : Hash.Hash {
    Text.hash(Nat.toText(n));
  };

  var nextId : Nat = 0;
  var calls = Map.HashMap<Nat, Call>(0, Nat.equal, natHash);


  public query func nelerSoylendi() : async [(Nat, Call)] {

    Iter.toArray(calls.entries())
  };

  public shared (msg) func kulaktanKulaga(content : Text) : async Text {
    
    let id = nextId;
    calls.put(id, {author = msg.caller; content = content; timestamp = Time.now()});
    nextId += 1;
      "Fısıltın duyuldu!  Fısıltı no:" # Nat.toText(id);
  };


  public func yeniOyun() : async Text {

    for (key : Nat in calls.keys()) {

      ignore calls.remove(key);
    };

    "Yeni oyun başlıyor!"
  };


  public query func basHarf() : async Text {
    let (_, text) = Iter.toArray(calls.entries())[nextId-1];
    let myVar : Text = text.content;
    let charArray = Text.toArray(myVar);
      let len = charArray.size();
      if (len == 0) {
          return "";
      };
      let last: Text = Text.fromChar(charArray[len - 1]);
      "Kelimeniz şu harfle başlamalı: " # last;
    
  };









};
