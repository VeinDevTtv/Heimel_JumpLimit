# Heimel_JumpLimit

A FiveM resource that restricts how many times a player can jump consecutively before they’re ragdolled.

## Features

- **Accurate jump detection** via control events.
- **Configurable** max jumps, cooldown, reset time, ragdoll duration.
- **Lightweight**—reduced polling frequency.
- **Debug mode** prints details to server console.

## Configuration

```lua
config = {
    maxJumps     = 2,    -- consecutive jumps allowed
    jumpCooldown = 1000, -- ms between jumps
    resetTime    = 5000, -- ms to clear count after last jump
    ragdollTime  = 3000, -- ms ragdoll lasts
    debug        = true, -- enable/disable debug logs
}```



---

**Next-Steps & Future Ideas**

- Expose an event (`Heimel_JumpLimit:playerRagdolled`) so other scripts can react (e.g. notify staff, deduct stamina).  
- Add a client UI counter/indicator (e.g. a small jump gauge on HUD).  
- Allow per-player or per-role whitelist/blacklist via server-side config.  
- Rate-limit debug events to avoid server log spam.  

This setup should be lean, maintainable, and easy to extend. Let me know if you’d like any of those features sketched out next!
