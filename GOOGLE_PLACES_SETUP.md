# 🗺️ Google Places API Integration Guide

## Setup Instructions (10 minutes)

### Step 1: Get Google Places API Key

1. **Go to Google Cloud Console:**
   https://console.cloud.google.com/

2. **Create a new project** (or use existing):
   - Click "Select a project" → "New Project"
   - Name: "FinPath"
   - Click "Create"

3. **Enable APIs:**
   - Go to "APIs & Services" → "Library"
   - Search for "Places API" → Click → Enable
   - Search for "Geocoding API" → Click → Enable
   - Search for "Maps JavaScript API" → Click → Enable

4. **Create API Key:**
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "API Key"
   - Copy the API key (looks like: `AIzaSyB...`)

5. **Restrict the Key** (optional but recommended):
   - Click on the key → "Edit API key"
   - Under "API restrictions":
     - Select "Restrict key"
     - Check: Places API, Geocoding API, Maps JavaScript API
   - Click "Save"

---

### Step 2: Add API Key to Your App

Open `lib/services/places_service.dart` and replace:

```dart
static const String _apiKey = 'YOUR_GOOGLE_PLACES_API_KEY_HERE';
```

With your actual key:

```dart
static const String _apiKey = 'AIzaSyB...'; // Your key
```

---

### Step 3: Test It!

```bash
flutter run
```

1. Complete onboarding with real location (e.g., "New York, NY")
2. Go to Explore tab
3. Select a category
4. See real local businesses! 🎉

---

## 📊 What the API Returns

For each place, you get:
- **Name** - Business name
- **Address** - Street address
- **Rating** - 1-5 stars
- **Price Level** - 0-4 ($-$$$$)
- **Distance** - From user location
- **Photos** - Business images (optional)
- **Open hours** - Business hours (optional)

---

## 💰 Pricing (Free Tier)

**Included for FREE:**
- ✅ 5,000 requests per month
- ✅ Basic place details
- ✅ Nearby search
- ✅ Geocoding

**Cost after free tier:**
- $17 per 1,000 requests
- You'll likely stay within free tier for hackathon!

---

## 🎯 Categories Mapped

| Your Category | Google Places Type | Example Results |
|---------------|-------------------|-----------------|
| Groceries | `supermarket` | Grocery stores, markets |
| Childcare | `school` | Daycares, preschools |
| Transport | `transit_station` | Bus stops, metro stations |
| Banking | `bank` | Banks, credit unions |

---

## 🔄 How It Works

```
User completes onboarding
Location: "San Francisco, CA"
        ↓
App geocodes location
→ Lat/Lng: 37.7749, -122.4194
        ↓
User taps "Groceries"
        ↓
API searches nearby supermarkets
        ↓
Returns 10 closest results
        ↓
Display with distance, ratings, prices
```

---

## 🚀 Alternative: Yelp Fusion API

If you prefer Yelp:

**Pros:**
- More detailed business info
- Better price data
- Reviews and photos
- Free: 5,000 calls/day

**Setup:**
1. Go to https://www.yelp.com/developers
2. Create app
3. Get API key
4. Similar integration

---

## 💡 For Your Demo

### Without API Key (Fallback):
> "For today's demo, we're showing curated local businesses. In production, this integrates with Google Places API to show real-time local data."

### With API Key:
> "Watch this - I'll search for grocery stores near [location]. These are REAL businesses from Google Places API, with actual ratings and distances."

*Tap category → Show real results*

> "See? Real local businesses, sorted by distance, with ratings and price levels. This works anywhere in the world!"

---

## 🛠️ Implementation Details

### Current Setup:

**File Created:** `lib/services/places_service.dart`

**Features:**
- ✅ Geocodes user location to lat/lng
- ✅ Searches nearby businesses by category
- ✅ Calculates distance from user
- ✅ Maps price levels to $ symbols
- ✅ Fallback to curated data if API unavailable

**Dependencies Added:**
- `http` - API calls
- `google_places_flutter` - Places widgets (optional)
- `geolocator` - Get device location
- `geocoding` - Convert addresses to coordinates

---

## 🎨 Enhanced Location Input

Want to make location input even better? I can add:

### Option 1: Google Places Autocomplete
- User types "New Y..."
- Dropdown shows "New York, NY"
- Select from suggestions
- More accurate!

### Option 2: Current Location
- "Use My Current Location" button
- GPS gets exact coordinates
- Super accurate!

### Option 3: Both!
- Autocomplete for manual entry
- GPS button for quick setup
- Best user experience

**Would you like me to add any of these?**

---

## 📝 Next Steps

### For Hackathon (Quick):
1. **Get API key** (10 minutes)
2. **Add to places_service.dart**
3. **Test with real location**
4. **Demo with real data!** 🎉

### For Production (Later):
1. Implement Places Autocomplete
2. Add location permissions
3. Cache results for offline
4. Add business details view
5. Show photos and reviews

---

## 🔑 Quick Setup Checklist

- [ ] Create Google Cloud project
- [ ] Enable Places API
- [ ] Enable Geocoding API
- [ ] Get API key
- [ ] Add key to `places_service.dart`
- [ ] Test in app
- [ ] Verify real businesses show

**Takes ~10 minutes total!**

---

## 💡 Pro Tip for Demo

Even without API key, your app works! The fallback shows curated recommendations. But with the API:

**Impact Statement:**
> "Our app uses Google Places API - the same technology powering Google Maps. This means we can show accurate, real-time local businesses anywhere in the world. No matter where a family moves, we've got them covered."

**This massively impresses judges! 🏆**

---

Would you like me to:
1. ✅ Add location autocomplete for better accuracy?
2. ✅ Add "Use My Location" button?
3. ✅ Show you how to get the API key?
4. ✅ Update the recommendations screen to use real data?

Let me know and I'll implement it! 🚀

