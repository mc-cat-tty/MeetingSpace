# MeetingSpace
Meeting space checker and generator for Google Meet

## check_meeting_space.sh
Launch this script to check if given room_code is valid or not (whether it exists or not)
Notice that meeting rooms are global and any valid authorization parameters (regardless of account) are suitable

### Usage
```
./meetIsActive.sh SAPISIDHASH x-goog-api-key x-goog-authuser __Secure-3PSID __Secure-3PAPISID room_code
```

### Output
POST response HTTP status code
- 200 -> meeting space exists
- 404 -> meeting space doesn't exist
- 400 -> bad request, the code is not valid
