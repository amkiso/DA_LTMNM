@props(['sach', 'class' => ''])

@if ($sach->hinh_anh)
    @php
        $coverUrl = str_starts_with($sach->hinh_anh, 'http://') || str_starts_with($sach->hinh_anh, 'https://')
            ? $sach->hinh_anh
            : asset('storage/'.ltrim($sach->hinh_anh, '/'));
    @endphp
    <img src="{{ $coverUrl }}" 
         alt="Bìa sách {{ $sach->ten_sach }}" 
         class="book-cover {{ $class }}"
         loading="lazy">
@else
    <div class="book-cover book-cover-placeholder {{ $class }}" role="img" aria-label="Bìa sách: {{ $sach->ten_sach }}">
        <span class="book-placeholder-badge">Thư viện</span>
        <i class="bi bi-journal-bookmark-fill book-placeholder-icon" aria-hidden="true"></i>
        <span class="book-placeholder-text px-2">{{ $sach->ten_sach }}</span>
    </div>
@endif
