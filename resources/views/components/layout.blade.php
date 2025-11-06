<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{ isset($title)?$title.'-Chirper':'Chirper' }}</title>
  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex flex-col">

  <!-- Navbar -->
  <nav class="flex justify-between items-center bg-white border-b border-gray-200 px-6 py-4">
    <div class="flex items-center space-x-2 text-xl font-bold text-gray-800">
      <span>🐦</span>
      <span>Chirper</span>
    </div>

    <div class="space-x-4">
      <a href="#" class="text-gray-800 font-medium hover:text-gray-600">Sign In</a>
      <a href="#" class="bg-gray-900 text-white px-4 py-2 rounded-md font-medium hover:bg-gray-700 transition">Sign Up</a>
    </div>
  </nav>

  <!-- Main Content -->
  <main class="flex-grow flex justify-center items-center">
    {{ $slot}}
  </main>
  <div>
    Powered by Chirper
  </div>


  <!-- Footer -->
  <footer class="bg-white border-t border-gray-200 text-center py-4 text-gray-600 text-sm">
    © 2025 <span class="font-semibold">Chirper</span> — Built with Laravel and ❤️
  </footer>

</body>
</html>
