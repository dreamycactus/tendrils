class UDNBot extends UTBot;

var Actor Destination;

protected event ExecuteWhatToDoNext()
{
  //Go to the roaming state
  GotoState('Roaming');
}

state Roaming
{
Begin:
  //If we just began or we have reached the Destination
  //pick a new destination - at random
  if(Destination == none || Pawn.ReachedDestination(Destination))
  {
    Destination = FindRandomDest();
  }

  //Find a path to the destination and move to the next node in the path
  MoveToward(FindPathToward(Destination), FindPathToward(Destination));

  //fire off next decision loop
  LatentWhatToDoNext();
}

defaultproperties
{
}